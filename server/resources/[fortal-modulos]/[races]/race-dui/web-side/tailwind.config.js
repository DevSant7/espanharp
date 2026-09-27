/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#5763D0",
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
