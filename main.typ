#import "@preview/datify:0.1.4": custom-date-format
#let lang = sys.inputs.at("lang", default: "es")
#let theme = sys.inputs.at("theme", default: "light")

#set text(lang: lang, font: "Inter")
#set page(paper: "a4", margin: 1.618cm, height: auto)

#let accent = rgb("#f6ab13")
#set line(stroke: accent)

#show sym.diamond.filled.small : set text(fill: accent)

#show heading.where(level: 1) : set text(weight: "bold", fill: accent, size: 24pt)
#show heading.where(level: 1) : set align(center)
#show heading.where(level: 2) : it => [
  #it
  // #place(dy: -1.5mm, line(length: 100%))
]
#show heading.where(level: 2): smallcaps
#show heading.where(level: 2): set text(weight: "extrabold")
#show heading.where(level: 3): it => [
  #it
  #place(
    dy: -1.5mm,
    line(length: 100%, stroke: 0.2mm)
  )
]

#show link: it => underline(it, stroke: 0.3mm + accent, offset: 0.75mm)

#let mainTranslation = yaml("i18n/" + lang + "/main.yml")

#let dateFormat(str) = {
  if str == "current" {
    return mainTranslation.current_job
  }
  let (month, year) = str.split("/");

  custom-date-format(datetime(day: 1, month: int(month), year: int(year)), "Month YYYY", lang)
}

#let cfgsStart = dateFormat("9/2019")
#let cfgsEnd = dateFormat("6/2021")

#place(
  dy: -4mm,
  line(length: 100%)
)
= David Castilla Ortiz

#align(center)[
  #stack(
    dir: ltr,
    spacing: 5mm,
    mainTranslation.city,
    sym.diamond.filled.small,
    link("https://www.linkedin.com/in/dcxo/")[LinkedIn],
    sym.diamond.filled.small,
    link("mailto:dcxo@proton.me"),
    sym.diamond.filled.small,
    link("tel:+34665354283")[+34 665 35 42 83],
  )
]

#place(
  dy: -1.5mm,
  line(length: 100%)
)
#line(length: 100%, stroke: 1mm)

#mainTranslation.brief

== #mainTranslation.section_titles.experience

#let experience((where, remote, title, from, to, keypoints)) = [
  === #where #text(weight: "light")[-- #mainTranslation.remote.at(remote, default: remote)] #h(1fr) #dateFormat(from) -- #dateFormat(to)
  #box(inset: (x: 4mm, top: 2mm))[
    #text(title, weight: "semibold")
    #list(..keypoints)
  ]
]

#yaml("i18n/" + lang + "/experience.yml").map(experience).join()

== #mainTranslation.section_titles.education

#yaml("i18n/" + lang + "/education.yml").map(((degree, kind, from, to, where, keypoints)) => [
  #box(inset: 2mm)[
    === *#degree*: #kind #h(1fr) #dateFormat(from) - #dateFormat(to) \
    #where

    #list(indent: 4mm, ..keypoints)
  ]
]).join()

== #mainTranslation.section_titles.skills

#yaml("i18n/" + lang + "/skills.yml").map(((name, skills)) => [
  - *#name*: #skills.join(", ")
]).join()

