---
name: spdf
description: Produce print-ready, visually sophisticated PDF documents (reports, proposals, brochures, one-pagers, invoices) using HTML+CSS with WeasyPrint or headless Chromium — precise page geometry, running headers/footers, page counters, table of contents with real page numbers, embedded SVG charts, cover pages, and full Arabic/RTL typography. Use when the user wants a final PDF deliverable.
license: MIT
compatibility: opencode
metadata:
  category: documents-design
  workflow: document-generation
  output: "PDF documents"
  stack: "WeasyPrint"
  rtl: "true"
  version: "1.0.0"
---

# spdf — إنشاء وتعديل ملفات PDF احترافية

مهارة متخصصة في إنتاج PDF نهائي بجودة مطبعة: هندسة صفحات دقيقة، رؤوس وتذييلات، ترقيم صفحات حقيقي، فهرس بأرقام صفحات فعلية، رسوميات مضمنة، وتايبوغرافيا عربية سليمة.

---

## 1. متى تستخدم هذه المهارة

- المستخدم يطلب PDF أو "ملف نهائي للطباعة" أو "تقرير PDF".
- تحويل مستند/محتوى موجود إلى PDF منسّق بشكل احترافي.
- عرض سعر، عرض فني، كتيب، ورقة بيانات (Datasheet)، تقرير سنوي، ملف شركة، شهادة، فاتورة.
- تعديل PDF موجود: إعادة إنتاج التصميم، دمج، إضافة صفحات غلاف/تذييل، ضغط، حماية بكلمة مرور.

لا تستخدمها عندما يريد المستخدم ملفاً قابلاً للتعديل (استخدم `sword`) أو صفحة ويب (استخدم `shtml`).

---

## 2. القاعدة الذهبية: اسأل أولاً — إلزامي

> **ممنوع كتابة سطر CSS واحد أو توليد أي PDF قبل الحصول على إجابات كافية.**
> حتى لو كان الطلب "اعمل لي تقرير PDF جميل" — هذا ليس كافياً.

### 2.1 البروتوكول

1. اطرح الحزمة الأولى من الأسئلة (4–5 أسئلة) عبر الأداة التفاعلية إن توفرت.
2. أكمل ما تبقّى في دفعة ثانية عند الضرورة (لا تتجاوز 3 دفعات).
3. اكتب **موجز تصميم (Design Brief)**: النوع، الجمهور، الستايل، الألوان، الخط، المقاس، عدد الصفحات، العناصر البصرية، مصدر المحتوى.
4. اطلب موافقة صريحة، ثم نفّذ.
5. بعد التوليد: حوّل الصفحات إلى صور PNG وراجعها بصرياً قبل التسليم.

### 2.2 الأسئلة الإلزامية

1. **الهدف:** ما الهدف من المستند؟ (تقرير / عرض سعر / كتيب / وثيقة تقنية / بروفايل شركة / فاتورة / شهادة / أخرى) وما عنوانه الرسمي؟
2. **الجمهور:** من الجمهور المستهدف؟ (إدارة عليا، عميل، جهة حكومية، مستثمر، فريق تقني، جمهور عام)
3. **الستايل:** Minimal / Corporate / Modern Dark / ملون قوي / فاخر Luxury / تقرير حكومي رسمي؟
4. **الألوان والهوية:** ألوان العلامة (HEX) أو وصفها؟ هل هناك خط شركة معتمد أو دليل هوية يجب الالتزام به؟
5. **الشعار والصور:** هل يوجد شعار/صور (ومساراتها)؟ ما درجة الدقة؟ هل أستخدم أيقونات SVG بديلة؟
6. **الحجم:** عدد الصفحات التقريبي؟ ومقاس الورق (A4 / A5 / Letter / عرض تقديمي أفقي 16:9)؟ طباعة وجهين؟
7. **العناصر البصرية:** جداول، رسوم بيانية، إنفوجرافيك، خرائط، رموز QR؟ ما البيانات ومصادرها؟
8. **المحتوى:** جاهز أم أكتبه من الصفر؟ وبأي لغة (عربي / إنجليزي / مختلط)؟
9. **تفاصيل إضافية:** اتجاه RTL/LTR، ترويسة وتذييل (اسم الجهة، التاريخ، رقم الإصدار، ترقيم «X من Y»)، صفحة غلاف، فهرس، سرية المستند، علامة مائية، حماية بكلمة مرور، متطلبات طباعة (خطوط مضمّنة، هوامش قطع، CMYK).

### 2.3 الحد الأدنى الكافي قبل البدء

| العنصر | مقبول كافٍ |
|---|---|
| النوع والجمهور | محددان أو موافَق على البديل |
| الألوان والستايل | HEX أو "اختر لي" + موافقة |
| المقاس وعدد الصفحات | محدد أو افتراضي معلن (A4، 4–8 صفحات) |
| المحتوى | مُرفق أو موافقة على الكتابة |
| الشعار | مسار محدد أو موافقة على العمل بدونه |

### 2.4 عند الرفض أو الغموض

اقترح حزمة افتراضية صريحة (**A4 عربي RTL، Corporate أزرق `1D4ED8`، خط Cairo، غلاف + فهرس + 5 أقسام**) واطلب موافقة بكلمة واحدة. لا تنفّذ بصمت.

---

## 3. اختيار المحرّك (قرار تقني مبكر)

| المحرّك | الأفضل لـ | العربية | الحدود |
|---|---|---|---|
| **WeasyPrint** (موصى به) | تقارير، فهارس بأرقام صفحات، رؤوس/تذييلات، طباعة دقيقة | ممتازة (Pango/HarfBuzz) | لا Grid كامل، دعم Flexbox جزئي |
| **Chromium headless** (Playwright) | تصميم معقّد، Grid، تأثيرات، خطوط ويب | ممتازة | رؤوس/تذييلات عبر CSS `@page` محدودة؛ استخدم `displayHeaderFooter` |
| **ReportLab** | فواتير/قوالب مولّدة برمجياً بدقة مطلقة | ضعيفة مباشرة (تحتاج `arabic_reshaper` + `python-bidi`) | بناء يدوي ممل |
| **LaTeX (XeLaTeX)** | أكاديمي/رياضي، جودة طباعة فائقة | جيدة مع `polyglossia` + خط عربي | منحنى تعلّم، صعوبة التصميم الحر |

**القاعدة:** ابدأ بـ WeasyPrint. إن احتجت Grid/تأثيرات معقّدة، انتقل إلى Chromium. استخدم ReportLab فقط عند الحاجة لتحكم برمجي في الإحداثيات.

```bash
pip install weasyprint pypdf pillow
# أدوات التحقق
pdftoppm -v; pdfinfo -v
# بديل: pip install playwright && playwright install chromium
```

---

## 4. المبادئ التصميمية

1. **الصفحة وحدة تصميم:** هوامش ثابتة، شبكة أفقية واحدة، لا عنصر يلامس حدّ الصفحة بلا قصد.
2. **تباين هرمي واضح:** عنوان الغلاف ≫ H1 ≫ H2 ≫ النص ≫ التقاطيع.
3. **اثنان فقط من الألوان الوظيفية** + محايدات؛ الألوان قليلة = مظهر فاخر.
4. **مساحة بيضاء سخية:** 25–35% من الصفحة فارغة — هذا ما يفصل "احترافي" عن "مزدحم".
5. **كل صفحة متوازنة:** لا صفحة عنوان يتيم في الأسفل، ولا صفحة تبدأ بجدول بلا سياق.
6. **تكرار مؤسسي:** نفس الغلاف، نفس الترويسة، نفس نمط الجداول والبطاقات في كل الصفحات.
7. **الطباعة أولاً:** لا خلفيات داكنة كاملة على مستند سيُطبع على ورق عادي إلا برضا المستخدم.
8. **الاتجاه:** `dir="rtl"` و `direction: rtl` على الجذر، مع ضبط `unicode-bidi` للنصوص المختلطة.

---

## 5. نظام التصميم: الألوان والخطوط والقياسات

### 5.1 لوحات جاهزة

| اللوحة | Ink | Accent | Accent2 | Surface | Border | Muted |
|---|---|---|---|---|---|---|
| Corporate Blue | `#0F172A` | `#1D4ED8` | `#0EA5A4` | `#F8FAFC` | `#E2E8F0` | `#64748B` |
| Modern Dark | `#0B1220` | `#38BDF8` | `#A78BFA` | `#111827` | `#1F2937` | `#94A3B8` |
| Luxury | `#1C1917` | `#B08D57` | `#7C2D12` | `#FAF7F2` | `#E7E1D8` | `#78716C` |
| Government | `#111827` | `#0F766E` | `#9A3412` | `#F9FAFB` | `#D1D5DB` | `#6B7280` |
| Vibrant | `#0F172A` | `#7C3AED` | `#F59E0B` | `#FAF5FF` | `#E9D5FF` | `#6B7280` |

لدعم التدرجات: `linear-gradient(135deg, #1D4ED8 0%, #0EA5A4 100%)` — مدعومة في WeasyPrint الحديث وChromium.

### 5.2 الخطوط

| الاستخدام | عربي | لاتيني | الحجم / الوزن |
|---|---|---|---|
| عنوان الغلاف | Cairo / Tajawal / Amiri | Inter / Playfair Display | 34–48pt · 700–800 |
| H1 | Cairo / Dubai | Inter | 22–26pt · 700 |
| H2 | Cairo | Inter | 15–17pt · 600 |
| نص | Cairo / IBM Plex Sans Arabic | Inter | 10–11.5pt · 400 · line-height 1.7–1.9 |
| تعليق/تسمية | Cairo | Inter | 8–9pt · 500 · Muted |
| أرقام KPI | Inter tabular | — | 28–36pt · 700 |
| كود | — | JetBrains Mono | 9pt |

قواعد الخطوط العربية:
- استخدم خطوطاً عربية حديثة: **IBM Plex Sans Arabic، Cairo، Tajawal، Almarai, Noto Kufi Arabic**؛ و**Amiri / Aref Ruqaa** للفاخر.
- ضمّن الخطوط محلياً عبر `@font-face` (مسار ملف) لا عبر CDN، لضمان ثبات المخرجات دون اتصال.
- `font-feature-settings: "kern","liga"` مفيد؛ لا تستخدم `letter-spacing` موجباً على العربية (يفكك الاتصال).
- لا `text-align: justify` للعربية بلا `text-align-last: start` و`hyphens: none`.
- تأكد من ظهور التشكيل والمدّات بشكل صحيح عند الخطوط الكوفية.

### 5.3 المقاسات والهوامش

- A4: `210mm × 297mm` — هوامش: أعلى 22mm، أسفل 20mm، داخل/خارج 18–20mm (وجهين: `@page :left/:right`).
- A5 كتيب: هوامش 14–16mm.
- مسافة بين الأقسام 10–14mm، بين الفقرة والتالية 4–6mm.
- شبكة سفلية: كل شيء من مضاعفات 2mm.

---

## 6. هيكل المستند المفضل

1. **الغلاف:** خلفية لونية/تدرّج، شعار، عنوان كبير، سطر وصفي، الجهة، التاريخ، الإصدار، تصنيف السرية. بلا ترويسة/تذييل/ترقيم.
2. **صفحة البيانات (Colophon):** جدول بيانات المستند + بيان السرية + سجل الإصدارات.
3. **الفهرس:** أرقام صفحات حقيقية عبر `target-counter`.
4. **الملخص التنفيذي:** بطاقة ملخص + 3–5 نتائج رئيسية.
5. **الأقسام:** H1 مع فاصل لوني، مقدمة قصيرة، نص/جداول/بطاقات، مع ترقيم تلقائي للعناوين.
6. **العناصر البصرية:** رسوم SVG مضمنة بألوان الهوية + تسمية «الشكل 1: …» ومصدر.
7. **التوصيات/الخطوات التالية.**
8. **الملاحق والمراجع.**
9. **صفحة ختام:** تواصل، شعار، QR (اختياري).

---

## 7. الوصفة التقنية (WeasyPrint + CSS)

### 7.1 الهيكل الكامل لملف CSS الأساسي

```css
/* ===== 1) تعريف الخطوط ===== */
@font-face { font-family: "Cairo"; src: url("fonts/Cairo-Regular.ttf"); font-weight: 400; }
@font-face { font-family: "Cairo"; src: url("fonts/Cairo-Bold.ttf");    font-weight: 700; }
@font-face { font-family: "Inter"; src: url("fonts/Inter-Regular.ttf"); font-weight: 400; }

/* ===== 2) التوكنات ===== */
:root{
  --ink:#0F172A; --body:#334155; --muted:#64748B;
  --accent:#1D4ED8; --accent2:#0EA5A4;
  --surface:#F8FAFC; --border:#E2E8F0;
}

/* ===== 3) هندسة الصفحة ===== */
@page{
  size: A4;
  margin: 22mm 18mm 20mm 18mm;
  @top-right{ content: string(doc-title); font: 600 8pt "Cairo"; color: var(--muted); }
  @top-left { content: "اسم الجهة"; font: 400 8pt "Cairo"; color: var(--muted); }
  @bottom-right{
    content: "صفحة " counter(page) " من " counter(pages);
    font: 400 8pt "Cairo"; color: var(--muted);
  }
  @bottom-left{ content: "سري — للاستخدام الداخلي"; font: 400 7.5pt "Cairo"; color: #94A3B8; }
}
@page cover{ margin:0; background: linear-gradient(160deg,#0F172A 0%,#1D4ED8 100%);
  @top-right{content:none} @top-left{content:none} @bottom-right{content:none} @bottom-left{content:none} }
@page :first{ /* أول صفحة بعد الغلاف */ }

/* ===== 4) الأساس ===== */
html{ direction: rtl; }
body{
  font-family: "Cairo","Inter",sans-serif; font-size: 10.5pt; line-height: 1.85;
  color: var(--body); -weasy-hyphens: none;
}
h1,h2,h3{ color: var(--ink); line-height: 1.35; break-after: avoid; page-break-after: avoid; }
h1{ font-size: 23pt; font-weight: 700; margin: 0 0 4mm; padding-block-end: 3mm;
    border-bottom: 2.5pt solid var(--accent); string-set: chapter content(); }
h2{ font-size: 15pt; font-weight: 600; margin: 8mm 0 3mm; }
h3{ font-size: 12pt; font-weight: 600; margin: 5mm 0 2mm; color: var(--accent); }
p{ margin: 0 0 4mm; text-align: start; }
```

### 7.2 الغلاف

```html
<section class="cover">
  <img class="logo" src="assets/logo-white.svg" alt="شعار">
  <div class="cover-body">
    <p class="kicker">تقرير أداء سنوي</p>
    <h1 class="cover-title">تقرير الأداء<br>لعام 2026</h1>
    <p class="cover-sub">تحليل المؤشرات التشغيلية والمالية وخطة التحسين</p>
  </div>
  <div class="cover-foot">
    <span>إدارة التخطيط الاستراتيجي</span><span>الإصدار 1.0 · أكتوبر 2026</span>
  </div>
</section>
```
```css
.cover{ page: cover; height: 297mm; display:flex; flex-direction:column;
        justify-content:space-between; padding: 28mm 22mm; color:#fff; break-after: page; }
.cover-title{ font-size: 40pt; line-height:1.2; color:#fff; border:0; margin:0 0 4mm; }
.kicker{ font-size:10pt; letter-spacing:.02em; opacity:.85; margin:0 0 6mm; }
.cover-sub{ font-size:12pt; opacity:.9; max-width:120mm; }
.logo{ width:34mm; }
```

### 7.3 فهرس بأرقام صفحات حقيقية

```html
<nav class="toc">
  <h2>المحتويات</h2>
  <ol>
    <li><a href="#sec-1">الملخص التنفيذي</a></li>
    <li><a href="#sec-2">منهجية التحليل</a></li>
  </ol>
</nav>
```
```css
.toc{ break-after: page; }
.toc ol{ list-style:none; padding:0; counter-reset: toc; }
.toc li{ counter-increment: toc; margin-bottom: 3.5mm; font-size: 11pt; }
.toc a{ text-decoration:none; color: var(--ink); }
.toc a::before{ content: counter(toc) ".  "; color: var(--accent); font-weight:700; }
.toc a::after{ content: leader('.') target-counter(attr(href), page); color: var(--muted); }
```

### 7.4 بطاقات، جداول، صناديق تنبيه

```css
.grid{ display:flex; flex-wrap:wrap; gap:4mm; }        /* WeasyPrint: تجنّب grid */
.card{ flex: 1 1 46%; background: var(--surface); border: 0.6pt solid var(--border);
       border-radius: 3mm; padding: 5mm; break-inside: avoid; }
.card .value{ font: 800 24pt "Inter"; color: var(--accent); }
.card .label{ font-size: 9pt; color: var(--muted); }

table{ width:100%; border-collapse: collapse; margin: 4mm 0 6mm; font-size: 9.5pt;
       break-inside: avoid; }
thead{ background: var(--ink); color:#fff; }
th{ font-weight:600; padding: 3mm 3mm; text-align: start; }
td{ padding: 2.6mm 3mm; border-bottom: 0.5pt solid var(--border); }
tbody tr:nth-child(even){ background: #F8FAFC; }
tfoot td{ font-weight:700; background:#EFF6FF; border-top: 2pt solid var(--accent); }
td.num{ font-family:"Inter"; direction:ltr; text-align:left; }  /* أرقام داخل جدول RTL */

.callout{ border-inline-start: 4pt solid var(--accent); background:#EFF6FF;
          padding: 4mm 5mm; border-radius: 2mm; break-inside: avoid; margin: 5mm 0; }
.callout.warn{ border-color:#B45309; background:#FFFBEB; }
.callout.danger{ border-color:#B91C1C; background:#FEF2F2; }
```

### 7.5 رسم بياني مضمن (SVG) — بلا مكتبات خارجية

```html
<figure>
  <svg viewBox="0 0 400 160" width="100%" role="img" aria-label="نمو الإيرادات">
    <rect x="20"  y="90" width="48" height="60" rx="4" fill="#1D4ED8" opacity=".35"/>
    <rect x="90"  y="70" width="48" height="80" rx="4" fill="#1D4ED8" opacity=".55"/>
    <rect x="160" y="45" width="48" height="105" rx="4" fill="#1D4ED8" opacity=".75"/>
    <rect x="230" y="20" width="48" height="130" rx="4" fill="#1D4ED8"/>
    <line x1="10" y1="152" x2="390" y2="152" stroke="#E2E8F0" stroke-width="1"/>
    <text x="44" y="170" font-size="10" fill="#64748B" text-anchor="middle">2023</text>
    <text x="114" y="170" font-size="10" fill="#64748B" text-anchor="middle">2024</text>
    <text x="184" y="170" font-size="10" fill="#64748B" text-anchor="middle">2025</text>
    <text x="254" y="170" font-size="10" fill="#64748B" text-anchor="middle">2026</text>
    <text x="254" y="14" font-size="11" font-weight="700" fill="#0F172A" text-anchor="middle">+38%</text>
  </svg>
  <figcaption>الشكل 1: نمو الإيرادات (مليون ريال) — المصدر: الإدارة المالية</figcaption>
</figure>
```
للرسوم المعقّدة: أنشئها بـ `matplotlib` (خط عربي مسجّل، `dpi=200`) واحفظها PNG/SVG ثم أدرجها.

### 7.6 التحويل والتحقق

```python
from weasyprint import HTML, CSS
HTML("doc.html", base_url=".").write_pdf("out.pdf", stylesheets=[CSS("styles.css")])
```

```bash
pdfinfo out.pdf | head -20            # عدد الصفحات، المقاس، الخطوط المضمّنة
pdffonts out.pdf | head              # تأكد أن الخطوط embedded (subset)
pdftoppm -png -r 96 out.pdf page     # معاينة كل صفحة كصورة ثم راجعها بصرياً
```
راجع: انقطاع عنصر بين صفحتين، عنوان في أسفل الصفحة، جدول مقسوم، نص يفيض عن الصفحة، علامات ترقيم عربية في الجهة الخطأ، صفر صفحة فارغة.

### 7.7 التعديل على PDF موجود

- استخراج/دمج/ترتيب الصفحات: `pypdf`.
- إضافة تذييل/ترقيم لملف PDF جاهز: **لا تعد الرسم فوق النص**؛ أعد توليد المستند بـ WeasyPrint إن أمكن (جودة أعلى وأنظف). إن لم يمكن، استخدم `pypdf` + `reportlab` لإنشاء طبقة تذييل (overlay) بشفافية.
- العلامة المائية: طبقة SVG/PNG شفافة متكررة عبر `position: fixed` في CSS، أو overlay في pypdf.
- الحماية: `pypdf` `encrypt()` بكلمة مرور مالك/مستخدم.

---

## 8. العناصر البصرية: قواعد الاستخدام

| العنصر | متى | كيف |
|---|---|---|
| غلاف بتدرّج | كل مستند احترافي | `linear-gradient` + شعار أبيض + عنوان 34–40pt |
| بطاقات KPI | ملخص تنفيذي | 3–4 بطاقات `flex` بنسبة 1:1، رقم كبير + تسمية + سهم اتجاه |
| شريط جانبي ملوّن | أقسام متسلسلة | `border-inline-start` أو شريط 4mm ملوّن قبل العنوان |
| إنفوجرافيك خط زمني | المنهجية/الخطة | صف أفقي من دوائر مرقّمة + خط واصل + تسميات |
| أيقونات | القوائم والبطاقات | SVG أحادي اللون 16–20px (`fill: currentColor`) |
| صورة بعرض كامل | التقارير التسويقية | `width:100%` + `break-inside: avoid` + تسمية |
| صناديق تنبيه | التحذيرات والملاحظات | 4pt حد جانبي + خلفية فاتحة + عنوان عريض |

ممنوع: صور مضغوطة بخلفية بيضاء داخل صفحة ملوّنة، أيقونات بألوان مختلفة بلا نظام، تدرّج لكل عنوان، خطوط عربية رقيقة جداً (وزن 300) في الطباعة.

---

## 9. أمثلة على أفضل الممارسات

**مثال 1 — افتتاحية قسم مثالية**
```
────────────────────────────  (2.5pt أزرق)
الثاني: نتائج التحليل            (23pt، Ink)
سطر وصفي 10.5pt Muted يشرح ما سيأتي ومدته الزمنية.
[بطاقة] +12.4%  نمو الإيرادات   [بطاقة] 98.2%  رضا العملاء
نص تحليلي قصير (3–4 أسطر) ثم جدول أو رسم.
```

**مثال 2 — جدول مالي نظيف**
- رأس غامق `#0F172A` بنص أبيض، صفوف متبادلة `#F8FAFC`.
- الأرقام LTR بمحاذاة يسار داخل خلية RTL، بفاصل آلاف، بلا كسور عشرية غير متسقة.
- صف الإجمالي بخلفية `#EFF6FF` وحد أعلى 2pt.
- ملاحظة 8pt: «الأرقام بملايين الريالات ومقرّبة.»

**مثال 3 — قبل/بعد**
- قبل: نص واحد طويل، بلا غلاف، تذييل بلا ترقيم، جداول بحدود شبكية كاملة.
- بعد: غلاف متدرّج، صفحة بيانات، فهرس بأرقام صفحات، H1 بفاصل لوني، بطاقات KPI، جدول بلا حدود عمودية، صناديق ملاحظات، تذييل «صفحة X من Y» + تصنيف السرية، خطوط مضمّنة.

---

## 10. أخطاء شائعة (تجنّبها)

1. استخدام CDN لخطوط ويب → ينتج خطاً بديلاً أو فشلاً كاملاً بلا اتصال.
2. نسيان `direction: rtl` على `html` → ترقيم وتخطيط مقلوبان.
3. `display:grid` في WeasyPrint → تخطيط منهار؛ استخدم `flex` أو جداول.
4. غياب `break-inside: avoid` → جدول/بطاقة مقسومة بين صفحتين.
5. هوامش صفرية مع محتوى يلامس الحافة → مظهر غير احترافي وغير قابل للطباعة.
6. أرقام صفحات ثابتة مكتوبة يدوياً بدل `counter(page)`.
7. خطوط غير مضمّنة → المستلم يرى خطاً مشوّهاً للعربية.
8. `letter-spacing` موجب على العربية → تفكيك الحروف.
9. تسليم بلا مراجعة بصرية للصفحات → أخطاء فيضان لا تظهر في الكود.
10. خلفية داكنة كاملة لمستند سيُطبع → استهلاك حبر غير متوقع (تحقق من نية الطباعة).

---

## 11. قائمة التحقق النهائية قبل التسليم

- [ ] الأسئلة التسعة طُرحت، والإجابات كافية، والموجز مُعتمد من المستخدم.
- [ ] المقاس الصحيح (A4/A5/Letter/عرضي) والهوامش مطابقة للمتفق عليه.
- [ ] RTL كامل: `dir="rtl"`، محاذاة `start`، أرقام بأعمدة LTR منفصلة.
- [ ] الخطوط العربية مضمّنة ومضبوطة الأوزان (متحقَّق عبر `pdffonts`).
- [ ] غلاف بلا ترويسة/تذييل، وفيه الجهة والتاريخ والإصدار.
- [ ] ترويسة وتذييل يعملان في كل الصفحات مع `counter(page)` و`counter(pages)`.
- [ ] الفهرس بأرقام صفحات فعلية (أو فهرس معرفي مذكور بدقة).
- [ ] لا عناصر مقطوعة بين صفحتين، ولا عناوين يتيمة في الأسفل.
- [ ] لا صفحات فارغة أو شبه فارغة.
- [ ] الجداول: رأس واضح، صفوف متبادلة، صف إجمالي، ملاحظات أسفلها.
- [ ] الرسوم بألوان الهوية، بعنوان ورقم ومصدر.
- [ ] التباين ≥ 4.5:1، والحجم لا يقل عن 9pt للنص.
- [ ] راجعت كل صفحة كصورة PNG بصرياً.
- [ ] حجم الملف معقول (< 10MB عادة)، واسم الملف واضح.
- [ ] سلّمت الملف + ملاحظة عن إمكانية إعادة التوليد بألوان/محتوى مختلف.
