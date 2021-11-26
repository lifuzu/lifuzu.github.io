
### When running `gatsby build`, it fails at:

  Error: Module parse failed: Unexpected token (26:34)
  You may need an appropriate loader to handle this file type, currently no loaders are configured to process this file. See https://webpack.js.org
  /concepts#loaders
  |
  | // Generates a slug from provided frontmatter/file path
  > const generateSlug = (frontmatter?: BasicFrontmatter): string | undefined => {
  |   if (frontmatter) {
  |     const { slug, title } = frontmatter;


