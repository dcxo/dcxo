import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";

export default defineConfig({
    site: "https://dcxo.dev",
    base: "/",
    devToolbar: {
        enabled: false,
    },
    integrations: [tailwind()],
});
