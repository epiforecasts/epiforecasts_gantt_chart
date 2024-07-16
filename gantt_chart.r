library("plotrix")
library("RColorBrewer")
library("readr")
library("tidyr")
library("dplyr")
library("lubridate")

roles <- c("PI", "Staff", "PhD", "Visitor")

df <- read_csv("data.csv") |>
  replace_na(list(end = today()))

vgridpos <- seq(floor_date(min(df$start), "year"), today(), by = "year")
vgridlab <- year(vgridpos)

colfunc <- colorRampPalette(
  c("#762a83", "#af8dc3","#e7d4e8","#d9f0d3","#7fbf7b","#1b7837")
)

timeframe <- c(min(df$start), today())

gantt_info <- df |>
  arrange(start) |>
  rename(starts = start, ends = end, labels = name) |>
  mutate(priorities = as.integer(factor(role, levels = roles))) |>
  select(-role)

#Plot and save your Gantt chart into PDF form
gantt.chart(
  gantt_info,
  taskcolors = colfunc(6),
  xlim = timeframe,
  main = "We are epiforecasts (est. 2017)",
  priority.legend = FALSE,
  vgridpos = vgridpos,
  vgridlab = vgridlab,
  hgrid = FALSE,
  half.height = 0.45,
  cylindrical = FALSE,
  border.col = "black",
  label.cex = 0.8,
  priority.label = "Role",
  priority.extremes = c("PI", "Visitor"),
  time.axis = 1)
            
legend(
  "bottomleft",
  roles,
  fill = colfunc(6),
  inset = .1
)
