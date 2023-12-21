const { addDynamicIconSelectors } = require("@iconify/tailwind");

import fontSizes from "./src/styles/fontSizes";
import colors from "./src/styles/colors";

/** @type {import('tailwindcss').Config} */
export default {
    content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
    darkMode: "class",
    theme: {
        extend: {
            height: {
                "full-dynamic": "100dvh",
            },
            animation: {
                "spin-react": "spin 10s linear infinite",
            },
        },
        fontSize: fontSizes,
        colors: {
            ...colors,
            current: "currentcolor",
        },
        fontFamily: {
            inter: "Inter, sans-serif",
        },
        variables: {
            DEFAULT: {
                color: colors,
            },
        },
    },
    plugins: [
        require("@mertasan/tailwindcss-variables"),
        addDynamicIconSelectors(),
    ],
};
