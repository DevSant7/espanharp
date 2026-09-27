function withOpacity(variableName) {
  return ({ opacityValue }) => {
    if (opacityValue !== undefined) {
      return `rgba(var(${variableName}), ${opacityValue})`;
    }
    return `rgb(var(${variableName}))`;
  };
}

/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      keyframes: {
        slideDownAndFade: {
          "0%": { opacity: 0, transform: "translateY(-2px)" },
          "100%": { opacity: 1, transform: "translateY(0)" },
        },
        slideUpAndFade: {
          "0%": { opacity: 0, transform: "translateY(2px)" },
          "100%": { opacity: 1, transform: "translateY(0)" },
        },
        slideLeftAndFade: {
          "0%": { opacity: 0, transform: "translateX(2px)" },
          "100%": { opacity: 1, transform: "translateX(0)" },
        },
        slideRightAndFade: {
          "0%": { opacity: 0, transform: "translateX(-2px)" },
          "100%": { opacity: 1, transform: "translateX(0)" },
        },
      },
      animation: {
        slideDownAndFade:
          "slideDownAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1) forwards",
        slideUpAndFade:
          "slideUpAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1) forwards",
        slideLeftAndFade:
          "slideLeftAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1) forwards",
        slideRightAndFade:
          "slideRightAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1) forwards",
      },
      fontFamily: {
        sans: ['"Space Grotesk"', "sans-serif"],
      },
      colors: {
        primary: withOpacity("--main-color"),
      },
      opacity: {
        1: "0.01",
        2: "0.02",
        3: "0.03",
        4: "0.04",
      },
      backgroundImage: {
        main: "linear-gradient(107.71deg, rgba(21, 22, 28, 0.98) 0%, rgba(22, 23, 27, 0.98) 100%)",
        button:
          "linear-gradient(91.14deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.006) 100%), radial-gradient(60.03% 95.47% at 49.84% 76.67%, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0) 100%)",
        buttonSelected:
          "linear-gradient(0deg, #2A52F2, #2A52F2), radial-gradient(60.03% 95.47% at 49.84% 76.67%, rgba(255, 255, 255, 0.25) 0%, rgba(255, 255, 255, 0) 100%)",
        section:
          "linear-gradient(91.14deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.006) 100%), radial-gradient(60.03% 95.47% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0) 100%)",
        modalbg:
          "linear-gradient(107.71deg, rgba(21, 22, 28, 0.85) 0%, rgba(22, 23, 27, 0.85) 100%)",
        modal:
          "linear-gradient(107.71deg, rgba(21, 22, 28, 0.98) 0%, rgba(22, 23, 27, 0.98) 100%)",
        out: "linear-gradient(91.14deg, rgba(255, 104, 104, 0.02) 0%, rgba(255, 104, 104, 0.012) 100%), radial-gradient(60.03% 95.47% at 49.84% 76.67%, rgba(255, 104, 104, 0.03) 0%, rgba(255, 104, 104, 0) 100%)",
      },
    },
  },
  plugins: [
    function ({ addUtilities }) {
      const newUtilities = {
        ".border": {
          borderWidth: "0.063rem",
          borderStyle: "solid",
        },
      };

      addUtilities(newUtilities, {
        variants: ["responsive"],
      });
    },
  ],
};
