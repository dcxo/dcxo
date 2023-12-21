const keyStorage = "dcxo.darkMode";
const lightModeValue = "light";
const darkModeValue = "dark";

export function toggleColorscheme(
    force?: typeof lightModeValue | typeof darkModeValue,
) {
    if (!!force) {
        document.documentElement.classList.toggle(
            keyStorage,
            darkModeValue === force,
        );
        localStorage.setItem(keyStorage, force);
        return;
    }

    let hasDarkMode = localStorage.getItem(keyStorage);

    if (hasDarkMode !== null) {
        hasDarkMode =
            hasDarkMode === lightModeValue ? darkModeValue : lightModeValue;

        localStorage.setItem(keyStorage, hasDarkMode);
    }

    document.documentElement.classList.toggle(
        darkModeValue,
        hasDarkMode === darkModeValue,
    );
}

export function detectColorscheme() {
    let hasDarkMode = localStorage.getItem(keyStorage);

    if (hasDarkMode === null) {
        hasDarkMode = matchMedia("(prefers-color-scheme: dark)").matches
            ? darkModeValue
            : lightModeValue;

        localStorage.setItem(keyStorage, hasDarkMode);
    }

    document.documentElement.classList.toggle(
        darkModeValue,
        hasDarkMode === darkModeValue,
    );
}
