type BaseInputs = {
    scale: number;
    viewportSize: number;
    baseFontSize: number;
};

type Inputs = {
    [P in keyof BaseInputs as `max${Capitalize<P>}`]: BaseInputs[P];
} & {
    [P in keyof BaseInputs as `min${Capitalize<P>}`]: BaseInputs[P];
} & {
    baseFontSize: number;
    steps: Steps;
};

type HarmonicSizesInput = Omit<BaseInputs, "viewportSize"> & {
    steps: readonly number[];
};
type StepName =
    | "sm"
    | "base"
    | "md"
    | "lg"
    | "xl"
    | "xs"
    | `${number}xl`
    | `${number}xs`;

export type Steps = Record<StepName, number>;

function create_harmonic_sizes({
    baseFontSize,
    scale,
    steps,
}: HarmonicSizesInput) {
    return steps.map(
        (step) => baseFontSize * Math.pow(scale, step >= 0 ? step : 1 / step),
    );
}

function calculate_slope_and_b(
    minFontSize: number,
    maxFontSize: number,
    minViewportSize: number,
    maxViewportSize: number,
): [number, number, number, number] {
    const slope =
        (maxFontSize - minFontSize) / (maxViewportSize - minViewportSize);
    const b = minFontSize - slope * minViewportSize;
    return [minFontSize, slope, b, maxFontSize];
}

export function create_clamps({
    maxBaseFontSize,
    maxScale,
    maxViewportSize,
    minBaseFontSize,
    minScale,
    minViewportSize,
    baseFontSize,
    steps,
}: Inputs) {
    const steps_value = Object.values(steps);
    const steps_names = Object.keys(steps) as StepName[];
    const minHarmonicSizes = create_harmonic_sizes({
        baseFontSize: minBaseFontSize,
        scale: minScale,
        steps: steps_value,
    });
    const maxHarmonicSizes = create_harmonic_sizes({
        baseFontSize: maxBaseFontSize,
        scale: maxScale,
        steps: steps_value,
    });

    const zip = minHarmonicSizes.map((value, index) => [
        value,
        maxHarmonicSizes[index],
    ]);
    const with_slopes = zip.map(([min, max]) =>
        calculate_slope_and_b(min, max, minViewportSize, maxViewportSize),
    );

    const clamps = with_slopes.map(
        ([minFontSize, slope, b, maxFontSize], index) => {
            return [
                steps_names[index],
                `clamp(${+(minFontSize / baseFontSize).toFixed(3)}rem, ${+(
                    slope * 100
                ).toFixed(3)}vw + ${+(b / baseFontSize).toFixed(3)}rem, ${+(
                    maxFontSize / baseFontSize
                ).toFixed(3)}rem)`,
                ,
            ] as const;
        },
    );

    return Object.fromEntries(clamps);
}
