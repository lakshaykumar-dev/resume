# Resume & Portfolio Workflow Guide

This document explains the structure of the repository, how to update the resume content, how to compile the PDF, and how to publish updates to GitHub Pages.

---

## 📁 Repository Overview

| File | Purpose | Tracked in Git |
|---|---|:---:|
| **`index.html`** | The public portfolio website hosted on GitHub Pages (`lakshaykumar-dev.github.io/resume`). Modern dark-mode glassmorphism design. | ✅ Yes |
| **`resume_v1.pdf`** | The compiled 1-page PDF downloaded by recruiters from the site. | ✅ Yes |
| **`update_resume.ps1`** | Automation script to stage, commit, and push updates to GitHub. | ✅ Yes |
| **`resume_v1.html`** | The source HTML used to generate the pixel-perfect 1-page PDF. Contains exact print stylesheets (`@page`, A4 sizing, line-height). | ℹ️ Local Source |
| **`resume_v1.tex`** | LaTeX source backup of the resume. | ℹ️ Local Source |
| **`html_to_pdf.py`** | Python script converting `resume_v1.html` into `resume_v1.pdf` using headless Chromium (Edge/Chrome). | ℹ️ Utility |
| **`tex_to_pdf.ps1`** | PowerShell script compiling `resume_v1.tex` to PDF via MiKTeX (requires installed TeX engines). | ℹ️ Utility |

---

## 🔄 Standard Update Workflow

Follow these 4 steps whenever adding new skills, roles, or projects:

### Step 1: Update the Portfolio (`index.html`)
- Update relevant sections in `index.html`:
  - **Technical Skills**: Inside `<section id="skills">`
  - **Experience**: Inside `<div class="experience-timeline">`
  - **Projects**: Inside `<div class="projects-stack">`
- Keep styling responsive; mobile breakpoints are defined in `@media (max-width: 640px)`.

### Step 2: Update the Printable Resume (`resume_v1.html` & `resume_v1.tex`)
- Update `resume_v1.html` with matching details in:
  - `<div class="skills">` (Technical Skills)
  - `<section><h2>EXPERIENCE</h2>` (Role highlights)
  - `<section><h2>PROJECTS</h2>` (Project details)
- Also update `resume_v1.tex` to keep the LaTeX version in sync.

### Step 3: Compile the PDF (`resume_v1.pdf`)
Run the Python conversion script in the project root:

```powershell
python html_to_pdf.py
```

> **Why `html_to_pdf.py`?**  
> `html_to_pdf.py` uses headless Microsoft Edge or Google Chrome with an isolated user profile. It renders `resume_v1.html` with exact print media styles (`@page { size: A4; margin: 9.5mm 10mm; }`) and generates a pixel-perfect, selectable, ATS-friendly PDF.

#### ⚠️ Keeping the PDF on Exactly 1 Page
The resume is strictly designed to fit on **1 single A4 page**. If new content pushes the document to 2 pages:
1. Open `resume_v1.html`.
2. Adjust print parameters in the `<style>` block (lines 7–16):
   ```css
   @page { size: A4; margin: 9.5mm 10mm; } /* tweak margins slightly if needed */
   body {
     font-size: 10.2px;   /* reduce to 10.0px or 10.1px if overflowing */
     line-height: 1.26;   /* reduce to 1.24 or 1.25 */
   }
   section { margin-top: 7px; } /* reduce section gap */
   ```
3. Re-run `python html_to_pdf.py`.
4. Verify page count in PowerShell:
   ```powershell
   python -c "import PyPDF2; print('Pages:', len(PyPDF2.PdfReader('resume_v1.pdf').pages))"
   ```
   Confirm output is: `Pages: 1`.

---

### Step 4: Commit and Push to GitHub

Use the provided PowerShell script:

```powershell
# With a custom commit message
.\update_resume.ps1 -Message "Update resume with new skill and project details"

# Or with default commit message ("Update resume")
.\update_resume.ps1
```

Alternatively, push manually with Git:
```powershell
git add index.html resume_v1.pdf
git commit -m "Update resume"
git push origin main
```

Within 1–2 minutes, GitHub Pages will automatically deploy the changes.

---

## 🎯 Content & Tone Guidelines
- **ATS-Friendly**: Use clear action verbs (*Engineered, Built, Led, Optimized, Used*) rather than buzzword fluff.
- **Specific Keywords**: Include concrete technologies (*Angular, .NET Core, AWS, Docker, Azure DevOps, SQL Server, Claude Code*).
- **Quantifiable Achievements**: Mention scale, versions, and awards (*Angular 20, 5-member team, Best Engineer Microsoft Award 2024*).
