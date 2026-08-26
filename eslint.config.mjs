import eslintComments from "@eslint-community/eslint-plugin-eslint-comments";
import js from "@eslint/js";
import globals from "globals";

export default [
  {
    ignores: ["vendor/**", "Example/Pods/**", "docs/**"],
  },
  js.configs.recommended,
  {
    plugins: {
      "@eslint-community/eslint-comments": eslintComments,
    },
    rules: {
      ...eslintComments.configs.recommended.rules,
    },
  },
  {
    files: ["**/*.js"],
    languageOptions: {
      globals: {
        ...globals.es2015,
        ...globals.node,
      },
    },
    rules: {
      "no-console": "off",
    },
  },
];
