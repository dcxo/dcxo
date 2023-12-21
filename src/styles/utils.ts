import { cva, type VariantProps } from "cva";

export const containerStyle = cva({
    base: "border-2 border-neutral-200 dark:border-0 rounded",
    variants: {
        elevation: {
            0: "dark:bg-neutral-900",
            1: "dark:bg-neutral-800",
            2: "dark:bg-neutral-700",
            3: "dark:bg-neutral-600",
        },
    },
    defaultVariants: {
        elevation: 0,
    },
});

export type ContainerProps = VariantProps<typeof containerStyle>;
