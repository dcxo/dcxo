import { defineConfig } from "astro/config";

import tailwind from "@astrojs/tailwind";

// https://astro.build/config
export default defineConfig({
    site: "https://dcxo.dev",
    base: "/",
    devToolbar: {
        enabled: false,
    },
    integrations: [tailwind()],
});
