const capitalizeWord = (text: string): string => text.length > 0 ? text[0]?.toUpperCase() + text.slice(1).toLowerCase() : "";
const wordToCamel = (text: string, index: number): string => index === 0 ? text.toLowerCase() : capitalizeWord(text);
/**
 * Partial application of a splitter function, that can be used before
 * converting a string to [camel case](https://en.wikipedia.org/wiki/Camel_case)
 * @example camelCase
 * @param splitter a function that splits the string into words
 */
const camelCase = (splitter: (textToSplit: string) => string[]) => (text: string) => text === "" ? "" : splitter(text).map(wordToCamel).join("");
/**
 * Split a string by Space
 * @param text the text to split
 */
const splitBySpace = (text: string): string[] => text.split(" ");
export const camelCaseUpper = (text: string, render: Function) => {
  const newText = camelCase(splitBySpace)(text);
  return render(newText.slice(0, 1).toUpperCase() + newText.slice(1));
};
export const firstUpper = (text: string, render: Function) => {
  return render(text.slice(0, 1).toUpperCase() + text.slice(1));
};
