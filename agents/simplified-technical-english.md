# Write in Simplified Technical English

Write all prose in Simplified Technical English (STE, the ASD-STE100
controlled-language style). This applies to everything you write for a human
reader: chat replies, code comments, docstrings, commit messages, PR
descriptions, design docs, and README files.

Sentence rules:
- Write one instruction or one idea per sentence.
- Keep procedural sentences to 20 words or fewer. Keep descriptive
  sentences to 25 words or fewer.
- Use the active voice. Use the imperative for instructions: "Run the
  migration first", not "The migration should be run first".
- Use the present tense when the present tense is accurate.
- Prefer positive statements. Avoid double negatives.
- Keep paragraphs short and give each paragraph one topic.

Word rules:
- Use one term for one thing. Do not switch synonyms for variety. If you
  call it a "worker" once, call it a "worker" every time.
- Use the shortest accurate word. Choose "use" over "utilize", "start"
  over "initiate", "before" over "prior to".
- Include articles: "the config file", not "config file".
- Do not stack more than three nouns. Rewrite "task queue retry limit
  config" as "the config for the task queue retry limit".
- Avoid idioms, metaphors, and figures of speech. "Delete the cache" is
  clear; "blow away the cache" is not.
- Avoid Latin abbreviations. Write "for example" and "that is" instead of
  "e.g." and "i.e.".
- Expand an acronym on first use, then use the acronym.
- Disambiguate `-ing` forms. Rewrite "the failing test config" as "the
  config for the test that fails".

Scope limits — STE governs the sentences you write, not the material you
describe:
- Never rename or simplify code identifiers, CLI flags, API fields, log
  strings, file paths, or established domain terms. Reproduce them exactly.
- Never simplify quoted text, error messages, or citations.
- STE does not mean shallow. Keep the mechanisms, numbers, trade-offs, and
  sources you would otherwise give. Simplify the sentence, not the content.
  This rule never overrides a depth, structure, or citation requirement
  from a project's own instructions.

When you dispatch a subagent, or spawn an external agent (for example GLM
through pi), state this STE requirement in the prompt you give it.

## Subagent coordination

Use the coding harness's native subagent tools for useful parallel or
specialized work. Keep the parent agent responsible for coordination and
integration.

Do not open cmux panes for subagents by default. Use cmux for subagent
coordination only when the user requests visible or interactive sessions.
