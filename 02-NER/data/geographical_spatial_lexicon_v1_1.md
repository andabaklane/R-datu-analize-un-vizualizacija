# Geographical Entity and Spatial Vocabulary Extraction — Historical Latvian Novels (1879–1940)

**Prompt version: 1.1**

## Task

Identify geographical named entities and generic spatial vocabulary in the provided text from a Latvian novel published between 1879 and 1940.

The purpose is to develop validated vocabularies for quantitative research on geographical references and the representation of urban, rural, natural, and built environments in historical Latvian literature.

Extract only expressions that actually occur in the supplied text, including recognizable inflected forms, historical spellings, and OCR-corrupted forms.

Return **unique canonical geographical names and unique dictionary lemmas of generic spatial terms**, not individual occurrences or frequency counts.

Normalize grammatical inflections, identifiable orthographic variations, and confidently recognizable OCR errors to the same canonical lexical entry.

Preserve distinct historical and alternative geographical names as separate lexical entries, even when they refer to the same physical location.

For generic spatial vocabulary, include qualifying lemmas regardless of whether their usage in the text is literal or metaphorical.

## 1. Geographical named entities

Extract proper names referring to specific geographical places.

### GPE — Geopolitical entities

Named countries, states, cities, towns, villages, administrative territories, and historical political regions.

Examples: *Latvija, Rīga, Parīze, Kurzeme, Vidzeme*.

### LOC — Geographical locations

Named natural geographical features and geographical regions that are not primarily political or administrative entities.

Examples: *Daugava, Gauja, Baltijas jūra, Alpi, Skandināvija, Eiropa*.

Include historical and fictional geographical names when they clearly identify specific places.

Do not extract personal names, organizations, institutions, or named buildings as geographical entities. Exclude named facilities and streets unless they clearly denote a geographical area rather than an individual structure.

### Geographical name normalization

Normalize inflected forms to the canonical nominative form of the corresponding name.

For example:

- *Daugavpilī* → `Daugavpils`
- *Rīgā* → `Rīga`
- *Daugavas* → `Daugava`

Normalize identifiable OCR errors to the intended geographical name when the identification is sufficiently clear.

For example:

- *D1nabur6a* → `Dinaburga`

**Do not merge distinct historical or alternative place names merely because they refer to the same geographical location.**

For example:

- *Daugavpils* → `Daugavpils`
- *Dinaburga* → `Dinaburga`

If both names occur in the supplied text, return two separate geographical entity entries.

Do not replace a historical geographical name with its modern equivalent merely for geographical standardization. The objective is lexical extraction, not geographical identity resolution.

## 2. Generic spatial vocabulary

Extract common nouns and established noun phrases denoting physical spaces, environments, buildings, and spatial infrastructure.

### URBAN — Urban spaces

Terms specifically denoting towns, cities, urban districts, and spatial features characteristic of urban environments.

Examples: *pilsēta, iela, bulvāris, kvartāls, priekšpilsēta, trotuārs*.

### RURAL — Rural and agricultural spaces

Terms denoting countryside settlements, agricultural land, farmsteads, and spatial structures characteristic of rural environments.

Examples: *lauki, viensēta, ciems, tīrums, ganības, muiža, klēts*.

### NATURAL — Natural environments and landscape features

Terms denoting natural spaces, landforms, bodies of water, and landscape features that may occur in either rural or urban environments.

Examples: *mežs, upe, ezers, kalns, purvs, pļava, jūra, krasts*.

### BUILT_ENVIRONMENT — Shared built spaces and infrastructure

Terms denoting buildings, constructed spaces, and infrastructure that may occur in both urban and rural environments and are not intrinsically characteristic of either.

Examples: *māja, istaba, pagalms, ceļš, tilts, stacija, fabrika*.

### Spatial vocabulary normalization and deduplication

Return each unique spatial lemma exactly once per supplied text, regardless of the number of occurrences.

Merge grammatical inflections, identifiable spelling variants, and confidently recognizable OCR errors under the canonical Latvian dictionary lemma.

For example:

- *cietoksnis* → `cietoksnis`
- *cietoksnī* → `cietoksnis`
- *citosknī* (recognizable OCR error in context) → `cietoksnis`
- *mežs*, *mežā*, *mežiem* → `mežs`

If multiple forms of the same lemma occur, return only one entry with one supporting textual form.

**Do not distinguish literal and metaphorical usage when constructing the unique spatial vocabulary.**

A spatial noun qualifies for extraction if its canonical lexical meaning denotes a physical space or spatial structure, even when the word is used metaphorically in the supplied text.

For example:

- *cietoksnis* used as a physical fortification → `cietoksnis`
- *cietoksnis* used metaphorically to describe emotional protection → `cietoksnis`
- *ceļš* used as a physical road → `ceļš`
- *ceļš* used metaphorically as a life journey → `ceļš`

In all cases, return the canonical lemma only once.

Do not create separate entries for literal and metaphorical uses. Do not include usage labels in the output.

## 3. Inclusion and exclusion criteria

### Include

- Explicit geographical proper names and generic spatial terms occurring in the text.
- Historical, regional, archaic, and non-standard vocabulary.
- Recognizable spelling variants and OCR-corrupted expressions whose intended lexical form can be reliably established.
- Relevant spatial nouns and established multiword expressions.
- References occurring in narration, dialogue, memories, comparisons, and descriptions.
- Spatial terms used literally or metaphorically, provided their canonical lexical meaning denotes a physical space, geographical feature, building, or spatial structure.

### Exclude

- People, occupations, social groups, and nationalities.
- Names of organizations, institutions, and individual buildings.
- Vehicles, machines, tools, furniture, and other movable objects.
- Activities, processes, and abstract concepts whose underlying lexical meanings do not denote physical spaces or spatial structures.
- Individual plants, animals, and weather phenomena.
- Spatial adverbs, directions, and grammatical location expressions.
- Terms that are only indirectly associated with rural or urban life but do not denote spaces or spatial structures.
- Words and place names not present in the supplied text, except canonical normalizations of forms that are actually present.
- Speculative corrections of severely corrupted text when the intended lexical identity cannot be established confidently.

## 4. Classification and normalization rules

1. Return each unique geographical name or generic spatial lemma only once per supplied text, even if it occurs repeatedly.

2. For geographical entities, normalize grammatical inflections to the canonical nominative form. Preserve distinct historical and alternative names rather than merging them under a modern geographical identity.

3. For generic spatial terms, provide the canonical Latvian dictionary lemma. For established multiword expressions, use the canonical form of the complete expression.

4. Normalize confidently recognizable OCR errors and orthographic variants to the intended canonical lexical entry. Use context to resolve errors, but do not invent uncertain corrections.

5. Provide one exact supporting textual form for every extracted item, copied verbatim from the input. The `evidence` field must preserve the original spelling, inflection, and any OCR errors present in the source text.

6. Assign exactly one of the six categories to each item.

7. Distinguish named places from generic spatial vocabulary. A geographical proper name belongs to `GPE` or `LOC`; a generic spatial term belongs to one of the other four categories.

8. Do not separately extract generic components of geographical proper names. For example, *Baltijas jūra* should not also produce *jūra* unless the latter occurs independently elsewhere in the text.

9. Classify generic terms according to their established spatial lexical meaning rather than the setting in which they occur. For example, *mežs* remains `NATURAL` even when referring to a forest within a city.

10. Use `NATURAL` for natural landscapes even when they may be used agriculturally, such as *pļava*. Use `RURAL` for specifically agricultural spaces, such as *tīrums* and *ganības*.

11. Use `BUILT_ENVIRONMENT` for general buildings and infrastructure that may occur in either urban or rural environments.

12. Include spatial lemmas regardless of literal or metaphorical usage. The canonical lemma and its spatial category remain the same across such uses.

13. Use textual context to distinguish genuine spatial lexemes from unrelated homonyms, personal names, and other expressions that do not belong to the defined vocabulary.

14. Do not infer geographical entities or spatial terms that are not explicitly represented in the text, apart from linguistic normalization or reliable OCR correction of attested expressions.

15. If the intended geographical name, spatial lemma, or lexical identity cannot be established with reasonable confidence, omit the candidate rather than guessing.

16. Do not calculate frequencies, count occurrences, or estimate the relative importance of extracted terms.

## 5. Output format

Return only a valid JSON object with two separate arrays: `geographical_entities` and `spatial_terms`.

Use the following structure:

```json
{
  "geographical_entities": [
    {
      "name": "Daugavpils",
      "category": "GPE",
      "evidence": "Daugavpilī"
    },
    {
      "name": "Dinaburga",
      "category": "GPE",
      "evidence": "D1nabur6a"
    },
    {
      "name": "Daugava",
      "category": "LOC",
      "evidence": "Daugavas"
    }
  ],
  "spatial_terms": [
    {
      "lemma": "pilsēta",
      "category": "URBAN",
      "evidence": "pilsētā"
    },
    {
      "lemma": "tīrums",
      "category": "RURAL",
      "evidence": "tīrumos"
    },
    {
      "lemma": "mežs",
      "category": "NATURAL",
      "evidence": "mežā"
    },
    {
      "lemma": "cietoksnis",
      "category": "BUILT_ENVIRONMENT",
      "evidence": "citosknī"
    }
  ]
}
```

The examples illustrate the output structure and normalization behavior. They must not be included unless the corresponding expressions actually occur in the supplied text.

The `name` and `lemma` fields must contain canonical normalized forms.

The `evidence` field must contain a verbatim expression from the supplied text, even when that expression contains an OCR error.

If several textual forms map to the same lemma, include only one entry and select one actual supporting form.

If no relevant items are found, return:

```json
{
  "geographical_entities": [],
  "spatial_terms": []
}
```

Do not include explanations, summaries, Markdown formatting, or text outside the JSON object.
