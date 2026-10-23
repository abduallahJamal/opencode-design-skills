# Usage — ready-to-use prompts

Real-world examples showing how each skill is triggered and what the agent is expected to do.

> 🌐 **English** · [العربية](usage-examples.md)

---

## 1) `sword` — Word

### A. Annual report
```text
use skill sword

Write a 2026 annual performance report for "Al-Nokhba Energy" (renewable energy).
- Audience: board of directors
- Style: Corporate, dark navy + gray
- Content: write from scratch (mid-size operational and financial results)
- 8–10 pages
- Include: KPI cards, 2024–2026 comparative financial table, revenue growth chart
- Header: company name + "2026 Annual Performance Report"
- Footer: "Confidential — internal use" + "Page X of Y"
```

**What the agent does:** asks the missing questions (logo? real or sample financials?), presents a design brief, builds the file, converts it to PDF, and reviews every page.

### B. Quotation
```text
Use the sword skill to create a consulting services quotation.
Logo: ./assets/logo.png — colors: #0F766E
Client: "Ofoq" — 4 service line items, priced table with quantities
Deliver an editable Word file plus a note that prices exclude VAT.
```

> **Important:** if you reference a logo path that does not exist, the skill will stop and ask — it will not invent a path.

---

## 2) `spdf` — PDF

### A. Technical proposal for print
```text
use skill spdf

Technical proposal for a solar energy supply and installation project.
- A4, 6–8 pages, duplex
- Style: Corporate with a luxury touch (gold #B08D57 on #1C1917)
- Include: cover, document-data page, TOC with page numbers, capability cards,
  technical specifications table, implementation timeline, contact page
- Font: IBM Plex Sans Arabic (embedded)
- Will be printed on plain paper — avoid full dark backgrounds
```

**What the agent does:** builds HTML+CSS, renders with WeasyPrint, verifies embedded fonts with `pdffonts`, converts each page to PNG, and reviews them.

### B. Convert an existing document
```text
I have a report as .docx (./input/report.docx). I want a professional PDF version:
company-branded cover, table of contents, and "Page X of Y" numbering.
Keep the content unchanged.
```

### C. Edit an existing PDF
```text
I have ./input/contract.pdf (12 pages). I want to:
1) add the footer "Confidential — copy 4" plus page numbers on every page
2) merge a cover from ./cover.pdf at the beginning
3) require a password to open: ****
```

---

## 3) `shtml` — HTML

### A. Report dashboard
```text
use skill shtml

A single HTML report page for Q3 results.
- English, single self-contained file, no external resources
- Corporate style, accent #1D4ED8
- Sections: hero, 4 KPI cards, results table, SVG chart, plan timeline, footer
- Responsive on mobile + automatic dark mode + print styles
- Content: realistic sample data
```

### B. Company profile
```text
A company profile landing page for a contracting firm.
Primary color #B45309, Tajawal font, add the logo from ./assets/logo.svg
Sections: about, services (6 cards), key numbers, projects, contact form, footer.
It must work fully offline.
```

### C. Convert a document into a page
```text
Convert the content of ./report.md into a professional HTML page using my brand
colors (#1D4ED8 + #0EA5A4), with a sticky side table of contents.
```

---

## 4) Tips for better results

| Do | Don't |
|---|---|
| Specify audience and style up front | "Make me a nice report" with no detail |
| Provide HEX codes if you have a brand | Rely on "blue" alone |
| Attach the logo and state its path | Assume the agent will find it |
| State the final format explicitly (Word/PDF/HTML) | Leave the format vague and object later |
| Review and request one specific change | "It's not good" without saying what to fix |

### Quick revision prompts

**Color change after delivery**
```text
Change the brand color from #1D4ED8 to #7C3AED across the whole file and regenerate.
```

**Condense / expand**
```text
The document is too long. Cut it to 3 pages while keeping every table and number.
```

**Swap an asset**
```text
Replace the logo with ./assets/logo-v2.png and regenerate with the same formatting.
```

---

## 5) Manual verification after delivery

Before accepting any file:

- **Word:** open it in Word (not only LibreOffice) and confirm Arabic renders in the intended font, headings appear in the Styles pane, and the page number field updates.
- **PDF:** `pdfinfo file.pdf` → correct page count and size. `pdffonts file.pdf` → every font shows `yes` under `emb`.
- **HTML:** open at 375px width — no horizontal scroll. Print to PDF once to test `@media print`.
