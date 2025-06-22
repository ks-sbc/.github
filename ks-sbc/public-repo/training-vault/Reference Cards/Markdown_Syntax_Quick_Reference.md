# Markdown Syntax Quick Reference Card

This card provides a quick summary of commonly used Markdown syntax for DRUIDS (Obsidian).

---

## Text Formatting

| Style         | Syntax                      | Example                      | Renders As                     |
|---------------|-----------------------------|------------------------------|--------------------------------|
| **Bold**      | `**text**` or `__text__`    | `**Important**`              | **Important**                  |
| *Italic*      | `*text*` or `_text_`        | `*emphasized*`               | *emphasized*                   |
| ~~Strikethrough~~ | `~~text~~`                  | `~~deleted~~`                | ~~deleted~~                    |
| **Bold & Italic** | `***text***` or `___text___` | `***really important***`     | ***really important***         |

---

## Headings

```markdown
# Heading 1 (Largest - typically for page titles)
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6 (Smallest)
```

---

## Lists

**Unordered Lists (Bullets)**
```markdown
- Item A
- Item B
  - Sub-item B1
  - Sub-item B2
* Another item (asterisk also works)
```
*Renders as:*
- Item A
- Item B
  - Sub-item B1
  - Sub-item B2
* Another item

**Ordered Lists (Numbers)**
```markdown
1. First item
2. Second item
   1. Sub-item 2.1 (indentation matters)
3. Third item
```
*Renders as:*
1. First item
2. Second item
   1. Sub-item 2.1
3. Third item

---

## Links

**Internal Links (Wikilinks - Obsidian specific)**
```markdown
[[Name of Your Note]]
[[Name of Your Note|Custom Display Text]]
[[Name of Your Note#Specific Heading|Link to a Heading]]
```

**External Links**
```markdown
[Link Text](https://www.example.com)
[Link Text with Title](https://www.example.com "Tooltip for the link")
<https://www.example.com> (Bare URL, becomes a link)
```
*Renders as:*
[Link Text](https://www.example.com)

---

## Images

```markdown
![Alt text for image](path/to/your/image.png "Optional Image Title")
```
*   `Alt text`: Describes the image for accessibility.
*   `path/to/your/image.png`: Can be a local path within your vault or a web URL.
*   `"Optional Image Title"`: Shows as a tooltip.

---

## Blockquotes

Used for quoting text from another source.
```markdown
> This is a blockquote.
> It can span multiple lines.
>
> > Nested blockquote.
```
*Renders as:*
> This is a blockquote.
> It can span multiple lines.
>
> > Nested blockquote.

---

## Code

**Inline Code**
Surround code with backticks `` ` ``.
```markdown
Use the `printf()` function for output.
```
*Renders as:*
Use the `printf()` function for output.

**Fenced Code Blocks**
Use triple backticks ``` ``` ```. Specify language for syntax highlighting.
````markdown
```python
def hello():
  print("Hello, world!")
```
````
*Renders as:*
```python
def hello():
  print("Hello, world!")
```

---

## Horizontal Rule

Creates a thematic break (a horizontal line). Use three or more hyphens, asterisks, or underscores.
```markdown
---
***
___
```
*Renders as:*
---

## Task Lists

Used for to-do items.
```markdown
- [ ] Task item not yet complete
- [x] Task item completed
  - [ ] Sub-task
```
*Renders as:*
- [ ] Task item not yet complete
- [x] Task item completed
  - [ ] Sub-task

---

This reference covers the most common Markdown syntax. For more advanced features or specific Obsidian behaviors, consult the official Obsidian documentation.
