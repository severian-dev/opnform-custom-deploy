export default defineAppConfig({
    icon: {
        cssLayer: "base",
    },
    ui: {
        colors: {
            // CUSTOMIZE THESE: Use Tailwind color names only (NO shade numbers, NO hex codes)
            // Available: slate, gray, zinc, neutral, stone, red, orange, amber, yellow,
            //            lime, green, emerald, teal, cyan, sky, blue, indigo, violet,
            //            purple, fuchsia, pink, rose
            // Shades (50-950) are auto-generated. Example: 'blue' → blue-50, blue-100, ..., blue-950
            // For custom hex colors, see COLOR_CONFIGURATION.md
            primary: "teal", // Main brand color - matches the mystical teal glow
            secondary: "emerald", // Secondary color - forest green undertones
            success: "emerald", // Success messages - keeps the forest theme
            error: "rose", // Error messages - softer than red, fits aesthetic
            warning: "amber", // Warning messages - warm accent (keep as is)
            info: "cyan", // Info messages - matches magical particle glow
            neutral: "zinc", // Neutral UI elements - cool dark grays
            form: "zinc", // Form-specific color - consistent with neutrals
        },

        tabs: {
            slots: {
                root: "space-y-0",
                list: "h-auto",
                trigger: "h-[30px]",
            },
        },

        keyboard: {
            defaultVariant: "subtle",
        },

        icons: {
            arrowLeft: "i-heroicons-arrow-left",
            arrowRight: "i-heroicons-arrow-right",
            check: "i-heroicons-check",
            chevronDoubleLeft: "i-heroicons-chevron-double-left",
            chevronDoubleRight: "i-heroicons-chevron-double-right",
            chevronDown: "i-heroicons-chevron-down",
            chevronLeft: "i-heroicons-chevron-left",
            chevronRight: "i-heroicons-chevron-right",
            chevronUp: "i-heroicons-chevron-up",
            close: "i-heroicons-x-mark",
            ellipsis: "i-heroicons-ellipsis-horizontal",
            external: "i-heroicons-arrow-up-right",
            folder: "i-heroicons-folder",
            folderOpen: "i-heroicons-folder-open",
            loading: "i-heroicons-arrow-path",
            minus: "i-heroicons-minus",
            plus: "i-heroicons-plus",
            search: "i-heroicons-magnifying-glass",
        },

        table: {
            slots: {
                td: "p-4 text-sm text-muted whitespace-normal [&:has([role=checkbox])]:pe-0",
            },
        },
    },
});
