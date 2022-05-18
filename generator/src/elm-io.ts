import path from 'node:path';
import jetpack from 'fs-jetpack';
const elmSourceDir = '../src/Bubblegum/Entity'

export const readElmContent = async (name: string): Promise<string> => {
    const filename = path.join(elmSourceDir, `${name}.elm`);
    const content =
      (await jetpack.readAsync(filename, 'utf8')) || '// Snippet not found';
    return content;
  };