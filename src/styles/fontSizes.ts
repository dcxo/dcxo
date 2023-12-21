import { create_clamps, type Steps } from "./fluidSizes";

const steps: Steps = {
    xs: -1,
    sm: -2,
    base: 0,
    md: 1,
    lg: 2,
    xl: 3,
    "2xl": 4,
    "3xl": 5,
};

const clamps = create_clamps({
    minBaseFontSize: 16,
    minScale: 1.25,
    minViewportSize: 400,
    maxBaseFontSize: 20,
    maxScale: 1.6, // (1 + Math.sqrt(5)) / 2,
    maxViewportSize: 1280,
    baseFontSize: 16,
    steps,
});

export default clamps;
