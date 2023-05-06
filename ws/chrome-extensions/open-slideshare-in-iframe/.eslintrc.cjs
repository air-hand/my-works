/* eslint-env node */
module.exports = {
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  rules: {
    "no-console": "warn",
    "@typescript-eslint/no-unused-vars": [
        "error", {
            "args": "none"
        }
    ],
    "@typescript-eslint/no-namespace": "off",
  },
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  parserOptions: {
    project: true,
    tsconfigRootDir: __dirname,
  },
  ignorePatterns: [
    "dist/*",
    "*.config.js",
    "tests/*",
  ],
  root: true,
};
