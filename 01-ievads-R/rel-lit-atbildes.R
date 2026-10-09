
## Patstāvīgā darba koda atbildes

# Šī sadaļa paredzēta pārbaudei pēc uzdevuma izpildes.

### Datu apakškopa

religiska_literatura <- tulkojumi |>
  filter(
    tematiska_grupa %in% c(
      "Reliģiskā literatūra",
      "Bērnu reliģiskā literatūra"
    )
  )

### 1. Lielākie reliģiskās literatūras izdevēji

religiska_literatura |>
  filter(izdevejs != "") |>
  count(
    izdevejs,
    name = "skaits",
    sort = TRUE
  ) |>
  slice_head(n = 10) |>
  ggplot(aes(
    x = skaits,
    y = reorder(izdevejs, skaits)
  )) +
  geom_col() +
  labs(
    title = "Lielākie tulkotās reliģiskās literatūras izdevēji",
    x = "Izdevumu skaits",
    y = NULL
  ) +
  theme_minimal()

### 2. Reliģiskās literatūras izdevumu skaits pa gadiem


religiska_literatura |>
  count(
    gads,
    name = "skaits"
  ) |>
  ggplot(aes(
    x = gads,
    y = skaits
  )) +
  geom_line() +
  labs(
    title = "Tulkotās reliģiskās literatūras izdevumu skaits pa gadiem",
    x = "Gads",
    y = "Izdevumu skaits"
  ) +
  theme_minimal()

### 3. Reliģiskā literatūra un bērnu reliģiskā literatūra

religiska_literatura |>
  count(
    gads,
    tematiska_grupa,
    name = "skaits"
  ) |>
  ggplot(aes(
    x = gads,
    y = skaits,
    color = tematiska_grupa
  )) +
  geom_line() +
  labs(
    title = "Tulkotās reliģiskās literatūras izdevumu skaits pa gadiem",
    subtitle = "Reliģiskā literatūra un bērnu reliģiskā literatūra",
    x = "Gads",
    y = "Izdevumu skaits",
    color = "Tematiskā grupa"
  ) +
  theme_minimal()