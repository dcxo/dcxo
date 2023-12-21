import { defineConfig } from "astro/config";
import purgecss from "astro-purgecss";

import tailwind from "@astrojs/tailwind";

// https://astro.build/config
export default defineConfig({
    devToolbar: {
        enabled: false,
    },
    integrations: [tailwind()],
});
