---
name: shtml
description: Build modern, responsive, self-contained HTML pages and reports (dashboards, company profiles, project reports, landing pages, proposals) with hand-written CSS design tokens, inline SVG icons, card layouts, KPI tiles, elegant tables, subtle motion, dark mode, print styles, and correct Arabic RTL. No external dependencies required. Use when the user asks for an HTML report, web page, or browser-viewable deliverable.
license: MIT
compatibility: opencode
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
metadata:
  category: documents-design
  workflow: web-deliverables
  output: "HTML pages and reports"
  stack: "HTML+CSS"
  rtl: "true"
  short-description: "Modern responsive HTML pages"
  version: "1.0.0"
---

# shtml — إنشاء صفحات وتقارير HTML احترافية

مهارة متخصصة في إنتاج صفحات HTML حديثة، نظيفة، متجاوبة، وذات مستوى بصري عالٍ — بملف واحد مستقل يعمل بلا إنترنت، وبعربية RTL صحيحة.

---

## 1. متى تستخدم هذه المهارة

- المستخدم يطلب صفحة ويب، تقرير HTML، داشبورد، بروفايل شركة، صفحة هبوط، عرض فني، أو "ملف HTML".
- يريد محتوى يُعرض في المتصفح فوراً أو يُطبع إلى PDF لاحقاً.
- تحويل مستند/بيانات إلى صفحة تفاعلية ببطاقات وجداول ورسوم.
- تحسين صفحة HTML موجودة: تنسيق، استجابة، RTL، إتاحة، طباعة.

لا تستخدمها للـ PDF النهائي (استخدم `spdf`) ولا لملفات Word (استخدم `sword`).

---

## 2. القاعدة الذهبية: اسأل أولاً — إلزامي

> **ممنوع كتابة أي HTML/CSS قبل الحصول على إجابات كافية.**
> "اعمل لي صفحة جميلة" ليست مواصفات — هي دعوة للأسئلة.

### 2.1 البروتوكول

1. اطرح الحزمة الأولى من الأسئلة (4–5 أسئلة) عبر الأداة التفاعلية إن توفرت.
2. أكمل المتبقي في دفعة ثانية (بحد أقصى 3 دفعات، بلا إغراق).
3. لخّص الإجابات في **موجز تصميم من 5–7 أسطر** واطلب موافقة صريحة.
4. نفّذ، ثم افتح الصفحة وافحصها بصرياً (لقطة شاشة) — لا تسلّم بلا معاينة.

### 2.2 الأسئلة الإلزامية

1. **الهدف:** ما الهدف من الصفحة؟ (تقرير / داشبورد / بروفايل شركة / صفحة هبوط / عرض فني / كتيب رقمي / محفظة أعمال) وما عنوانها؟
2. **الجمهور:** من الجمهور المستهدف؟ (إدارة، عملاء، مستثمرون، فريق تقني، جمهور عام) وعلى أي جهاز سيفتحها غالباً (جوال / مكتبي)؟
3. **الستايل:** Minimal / Corporate / Modern Dark / ملون قوي / فاخر Luxury / تقني (Tech).
4. **الألوان والهوية:** ألوان العلامة (HEX) أو وصفها؟ هل يوجد شعار وخط هوية؟
5. **الشعار والصور:** هل لديك شعار/صور/أيقونات؟ مساراتها؟ ولون الخلفية المطلوب للشعار؟
6. **الحجم:** صفحة واحدة أم متعددة الأقسام؟ ما الطول التقريبي والمحتوى الرئيسي؟
7. **العناصر البصرية:** بطاقات؟ جداول؟ رسوم بيانية؟ عدّادات؟ خط زمني؟ نماذج تواصل؟ خريطة؟
8. **المحتوى:** جاهز أم أكتبه من الصفر؟ بأي لغة (عربي / إنجليزي / مختلط)؟
9. **تفاصيل إضافية:** RTL أم LTR؟ الوضع الليلي؟ تعدّد اللغات؟ ملف واحد أم مشروع بعدة ملفات؟ هل تريد Tailwind أم CSS مخصص؟ هل يلزم أن يعمل بلا إنترنت؟ هل تُطبع الصفحة إلى PDF؟

### 2.3 الحد الأدنى الكافي قبل البدء

| العنصر | مقبول كافٍ |
|---|---|
| النوع والجمهور | محددان أو موافَق على البديل |
| الستايل والألوان | HEX أو "اختر لي" + موافقة |
| المحتوى | مُرفق أو موافقة على الكتابة |
| اللغة والاتجاه | محددان |
| نطاق الملف | صفحة واحدة / مشروع (مهم للهيكل) |

### 2.4 عند الرفض أو الغموض

اقترح حزمة افتراضية صريحة (**صفحة واحدة عربية RTL، Corporate أزرق `#1D4ED8`، بطاقات KPI + جدول + خط زمني، ملف مستقل بلا اعتماديات**) واطلب موافقة بكلمة واحدة.

---

## 3. قرارات تقنية مبكرة

| القرار | القاعدة |
|---|---|
| Tailwind أم CSS مخصص؟ | **CSS مخصص بتوكنات (var) هو الافتراضي** — ملف واحد، يعمل دون إنترنت، تحكّم كامل. Tailwind CDN يفشل بلا شبكة وفي المعاينات المعزولة. إن طلب المستخدم Tailwind صراحة، استخدم Tailwind CLI لتوليد CSS مضمّن (`dist` مضمّن) أو إلصق CSS المُجمّع داخل `<style>`. |
| ملف واحد أم مشروع؟ | افتراضياً **ملف HTML واحد مستقل** (CSS/JS/SVG مضمّنة) لسهولة المشاركة والمعاينة. مشروع متعدد الملفات فقط عند طلب المستخدم أو كبر الحجم. |
| الخطوط | ممنوع الاعتماد على CDN؛ استخدم `font-family` بنظام خطوط النظام، أو `@font-face` مع ملفات محلية/`data:` URI إن توفرت. |
| الأيقونات | SVG مضمّن (`stroke="currentColor"`) — لا مكتبات أيقونات خارجية. |
| الرسوم البيانية | SVG/CSS مخصصة للبسيط؛ Chart.js/CDN فقط إن وافق المستخدم على الاعتماد الخارجي. |
| الصور | مسارات محلية أو `data:` URI. لا صور من الإنترنت في مخرجات المعاينة المعزولة. |

> تنبيه بيئي: المعاينة داخل التطبيق تعمل في إطار معزول بلا شبكة. أي `<link>`/`<script src>` خارجي أو خط CDN لن يُحمّل. اجعل الملف مستقلاً بالكامل، واذكر للمستخدم إن كان قد طلب اعتماداً خارجياً.

---

## 4. المبادئ التصميمية

1. **هرمية بصرية حاسمة:** عنوان رئيسي واسع وواضح، عناوين أقسام أقل وزناً، نص مقروء — لا مسطّحاً متساوياً.
2. **الشبكة والمسافات:** نظام مسافات على أساس 4/8px، حاويات `max-width: 1140–1280px`، حشو أقسام 64–96px على المكتبي و32–48px على الجوال.
3. **لون واحد قوي + محايدات:** تدرّج/لون هوية واحد يُستخدم بانتظام للإجراءات والتمييز، لا "قوس قزح".
4. **حركة خفيفة ذات معنى:** انتقالات 150–250ms، `translateY(-2px)` أو تغيّر ظل عند التمرير — لا حركة مستمرة ولا تأثيرات مبالغ فيها.
5. **صفحة متجاوبة حقيقية:** تعمل على 360px و768px و1440px؛ لا أعراض تمرير أفقي.
6. **إتاحة:** تباين ≥ 4.5:1، `:focus-visible` واضح، HTML دلالي، `alt` لكل صورة، `lang`/`dir` صحيحان.
7. **يعمل بلا إنترنت وبلا JS:** اجعل كل المحتوى قابلاً للقراءة عند تعطيل JS؛ JS للتحسين فقط.
8. **قابل للطباعة:** تنسيق `@media print` نظيف (يُستخدم غالباً لتحويل التقرير إلى PDF).

---

## 5. نظام التصميم: توكنات

```css
:root{
  /* الألوان */
  --ink:#0F172A; --body:#334155; --muted:#64748B;
  --accent:#1D4ED8; --accent-2:#0EA5A4; --accent-soft:#EFF6FF;
  --bg:#FFFFFF; --surface:#F8FAFC; --border:#E2E8F0;
  --success:#15803D; --warn:#B45309; --danger:#B91C1C;
  /* الخطوط */
  --font-ar:"IBM Plex Sans Arabic","Cairo","Tajawal","Segoe UI",Tahoma,sans-serif;
  --font-ui:"Inter","Segoe UI",system-ui,sans-serif;
  --font-mono:"JetBrains Mono",ui-monospace,monospace;
  /* المقاسات */
  --fs-xs:12px; --fs-sm:14px; --fs-base:16px; --fs-lg:18px;
  --fs-h3:22px; --fs-h2:30px; --fs-h1:44px; --fs-display:58px;
  --lh-tight:1.2; --lh-body:1.85;
  /* المسافات والحواف */
  --s1:4px; --s2:8px; --s3:12px; --s4:16px; --s5:24px;
  --s6:32px; --s7:48px; --s8:64px; --s9:96px;
  --r-sm:8px; --r-md:14px; --r-lg:20px; --r-full:999px;
  --shadow-sm:0 1px 2px rgba(15,23,42,.06), 0 1px 3px rgba(15,23,42,.05);
  --shadow-md:0 4px 12px rgba(15,23,42,.07), 0 12px 32px rgba(15,23,42,.06);
  --container:1200px;
}
@media (prefers-color-scheme: dark){
  :root{
    --ink:#E8EEF9; --body:#C3CEDF; --muted:#94A3B8;
    --bg:#0B1220; --surface:#111A2B; --border:#1F2A3C; --accent-soft:#12203A;
  }
}
```

### 5.1 لوحات جاهزة

| اللوحة | Ink | Accent | Accent2 | Surface |
|---|---|---|---|---|
| Corporate Blue | `#0F172A` | `#1D4ED8` | `#0EA5A4` | `#F8FAFC` |
| Modern Dark | `#0B1220` | `#38BDF8` | `#A78BFA` | `#111827` |
| Luxury | `#1C1917` | `#B08D57` | `#7C2D12` | `#FAF7F2` |
| Vibrant | `#0F172A` | `#7C3AED` | `#F59E0B` | `#FAF5FF` |
| Tech | `#0E1726` | `#22D3EE` | `#818CF8` | `#0F1B2D` |

### 5.2 الخطوط والقياسات

- العربية: `IBM Plex Sans Arabic` / `Cairo` / `Tajawal` / `Almarai`؛ الفاخر: `Amiri` للعناوين. سلسلة احتياطية إلزامية: `"Segoe UI", Tahoma, sans-serif`.
- أحجام فعلية باستخدام `clamp()`: `--fs-h1: clamp(30px, 5vw, 46px)`.
- `line-height` للعربية 1.8–1.9؛ لا `letter-spacing` موجب على العربية (يفكك الحروف).
- نصوص طويلة: `max-width: 68ch`.
- الوزن: 700 للعناوين، 600 للعناوين الفرعية، 400 للنص، 500 للأزرار والتسميات.

---

## 6. هيكل الصفحة المفضل

1. **شريط علوي (Header):** شعار يمين + تنقّل بسيط وسط/يسار + زر إجراء واحد بارز. `position: sticky` + خلفية شبه شفافة `backdrop-filter`.
2. **Hero:** عنوان كبير + سطر وصفي + زرّان (أساسي/ثانوي) + بطاقة/رسم صغير على الجانب.
3. **شريط مؤشرات (KPI):** 3–4 بطاقات أرقام كبيرة + تسمية + سهم اتجاه ملوّن.
4. **أقسام المحتوى:** كل قسم = عنوان + مقدمة قصيرة + محتوى (بطاقات / جدول / خط زمني / رسم).
5. **قسم تمييز (Highlight):** خلفية ملوّنة أو تدرّج واحد في الصفحة لجذب الانتباه (اقتباس، إحصائية، دعوة إجراء).
6. **خاتمة/تواصل:** بيانات، نموذج بسيط (اختياري)، شعار، حقوق.
7. **Footer:** روابط، سرية، تاريخ التحديث.

قواعد إضافية: `id` لكل قسم لتنقّل `#anchor`؛ مكوّن واحد مكرّر لا يزيد على 5 مرات إن أمكن؛ لا أقسام فارغة.

---

## 7. الوصفة التقنية

### 7.1 هيكل الملف الواحد

```html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>تقرير الأداء 2026</title>
<meta name="description" content="وصف مختصر للصفحة">
<style>
  /* 1) توكنات  2) أساس  3) تخطيط  4) مكوّنات  5) استجابة  6) طباعة */
</style>
</head>
<body>
  <a class="skip" href="#main">تجاوز إلى المحتوى</a>
  <header class="site-header">…</header>
  <main id="main">…</main>
  <footer class="site-footer">…</footer>
  <script>/* تحسينات اختيارية فقط */</script>
</body>
</html>
```

### 7.2 أساس نظيف

```css
*,*::before,*::after{ box-sizing:border-box; }
html{ -webkit-text-size-adjust:100%; scroll-behavior:smooth; }
body{
  margin:0; background:var(--bg); color:var(--body);
  font-family:var(--font-ar); font-size:var(--fs-base); line-height:var(--lh-body);
  text-rendering:optimizeLegibility;
}
h1,h2,h3{ color:var(--ink); line-height:var(--lh-tight); margin:0 0 var(--s3);
          letter-spacing:0; font-weight:700; }
h1{ font-size:clamp(30px,5vw,46px); } h2{ font-size:clamp(22px,3vw,32px); }
h3{ font-size:var(--fs-h3); font-weight:600; }
p{ margin:0 0 var(--s4); max-width:68ch; }
a{ color:var(--accent); text-decoration-thickness:1.5px; text-underline-offset:3px; }
img,svg{ max-width:100%; height:auto; display:block; }
:focus-visible{ outline:2.5px solid var(--accent); outline-offset:3px; border-radius:var(--r-sm); }
.skip{ position:absolute; inset-inline-start:-9999px; }
.skip:focus{ inset-inline-start:var(--s4); top:var(--s4); z-index:99;
             background:var(--bg); padding:var(--s2) var(--s4); border-radius:var(--r-sm); }
.container{ width:min(100% - 2*var(--s5), var(--container)); margin-inline:auto; }
.section{ padding-block: clamp(32px, 6vw, 88px); }
.section--alt{ background:var(--surface); border-block:1px solid var(--border); }
.eyebrow{ font-size:var(--fs-sm); font-weight:600; color:var(--accent);
          text-transform:none; margin-bottom:var(--s2); display:flex; align-items:center; gap:var(--s2); }
.eyebrow::before{ content:""; width:22px; height:2px; background:var(--accent); border-radius:2px; }
```

### 7.3 الهيدر والـ Hero

```html
<header class="site-header">
  <div class="container header-inner">
    <a class="brand" href="#"><svg width="28" height="28" aria-hidden="true">…</svg> اسم الجهة</a>
    <nav class="nav" aria-label="التنقل الرئيسي">
      <a href="#kpi">المؤشرات</a><a href="#results">النتائج</a><a href="#plan">الخطة</a>
    </nav>
    <a class="btn btn--primary" href="#contact">تواصل معنا</a>
  </div>
</header>
```
```css
.site-header{ position:sticky; top:0; z-index:50; background:color-mix(in srgb, var(--bg) 85%, transparent);
  backdrop-filter:saturate(180%) blur(10px); border-bottom:1px solid var(--border); }
.header-inner{ display:flex; align-items:center; justify-content:space-between; gap:var(--s5); min-height:68px; }
.brand{ display:flex; align-items:center; gap:var(--s2); font-weight:700; color:var(--ink);
        text-decoration:none; font-size:var(--fs-lg); }
.nav{ display:flex; gap:var(--s5); }
.nav a{ color:var(--body); text-decoration:none; font-size:var(--fs-sm); font-weight:500;
        padding:6px 2px; border-bottom:2px solid transparent; transition:color .18s, border-color .18s; }
.nav a:hover{ color:var(--accent); border-color:var(--accent); }
@media (max-width: 780px){ .nav{ display:none; } }
```

### 7.4 الأزرار والبطاقات

```css
.btn{ display:inline-flex; align-items:center; gap:var(--s2); padding:12px 22px;
  border-radius:var(--r-full); font-weight:600; font-size:var(--fs-sm); text-decoration:none;
  transition:transform .16s ease, box-shadow .16s ease, background .16s ease; border:1px solid transparent; }
.btn--primary{ background:var(--accent); color:#fff; box-shadow:var(--shadow-sm); }
.btn--primary:hover{ transform:translateY(-2px); box-shadow:var(--shadow-md); filter:brightness(1.05); }
.btn--ghost{ background:transparent; color:var(--ink); border-color:var(--border); }
.btn--ghost:hover{ background:var(--surface); transform:translateY(-2px); }

.grid{ display:grid; gap:var(--s5); }
.grid--3{ grid-template-columns:repeat(3,1fr); }
.grid--4{ grid-template-columns:repeat(4,1fr); }
@media (max-width: 960px){ .grid--3,.grid--4{ grid-template-columns:repeat(2,1fr); } }
@media (max-width: 620px){ .grid--3,.grid--4{ grid-template-columns:1fr; } }

.card{ background:var(--bg); border:1px solid var(--border); border-radius:var(--r-lg);
  padding:var(--s5); box-shadow:var(--shadow-sm);
  transition:transform .18s ease, box-shadow .18s ease, border-color .18s ease; }
.card:hover{ transform:translateY(-3px); box-shadow:var(--shadow-md); border-color:var(--accent); }
.card .icon{ width:44px; height:44px; display:grid; place-items:center; border-radius:var(--r-md);
  background:var(--accent-soft); color:var(--accent); margin-bottom:var(--s3); }

/* بطاقة KPI */
.kpi{ background:linear-gradient(160deg, var(--bg), var(--surface));
  border:1px solid var(--border); border-radius:var(--r-lg); padding:var(--s5); }
.kpi .value{ font-family:var(--font-ui); font-size:clamp(26px,3vw,36px); font-weight:800;
  color:var(--ink); line-height:1.1; font-variant-numeric:tabular-nums; }
.kpi .label{ font-size:var(--fs-sm); color:var(--muted); margin-top:var(--s1); }
.kpi .trend{ font-size:var(--fs-xs); font-weight:700; }
.kpi .trend.up{ color:var(--success); } .kpi .trend.down{ color:var(--danger); }
```

### 7.5 جداول أنيقة ومتجاوبة

```css
.table-wrap{ overflow-x:auto; border:1px solid var(--border); border-radius:var(--r-md); }
table{ width:100%; border-collapse:collapse; font-size:var(--fs-sm); }
thead th{ background:var(--ink); color:#fff; text-align:start; font-weight:600;
  padding:14px 16px; white-space:nowrap; }
tbody td{ padding:13px 16px; border-bottom:1px solid var(--border); }
tbody tr:nth-child(even){ background:var(--surface); }
tbody tr:hover{ background:var(--accent-soft); }
tfoot td{ font-weight:700; background:var(--accent-soft); border-top:2px solid var(--accent); }
td.num{ font-family:var(--font-ui); font-variant-numeric:tabular-nums; direction:ltr; text-align:left; }
.badge{ display:inline-block; padding:3px 10px; border-radius:var(--r-full);
  font-size:var(--fs-xs); font-weight:600; }
.badge--ok{ background:#DCFCE7; color:#15803D; }
.badge--warn{ background:#FEF3C7; color:#B45309; }
```
على الجوال: إما تمرير أفقي (`table-wrap`) أو تحويل الجدول إلى بطاقات بـ `data-label` + `::before` — اختر واحداً والتزم به.

### 7.6 خط زمني / إنفوجرافيك بسيط

```html
<ol class="timeline">
  <li><span class="dot">1</span><h3>التهيئة</h3><p>جمع البيانات وتحديد النطاق.</p></li>
  <li><span class="dot">2</span><h3>التحليل</h3><p>قياس المؤشرات ومقارنة المستهدف.</p></li>
  <li><span class="dot">3</span><h3>التنفيذ</h3><p>خطط تصحيحية بمسؤوليات ومواعيد.</p></li>
</ol>
```
```css
.timeline{ list-style:none; margin:0; padding:0; display:grid; gap:var(--s5);
  grid-template-columns:repeat(3,1fr); position:relative; }
.timeline li{ position:relative; padding-top:var(--s6); }
.timeline .dot{ position:absolute; top:0; inset-inline-start:0; width:32px; height:32px;
  display:grid; place-items:center; border-radius:var(--r-full);
  background:var(--accent); color:#fff; font-weight:700; font-family:var(--font-ui); }
.timeline li::before{ content:""; position:absolute; top:16px; inset-inline-start:32px;
  inset-inline-end:0; height:2px; background:var(--border); }
.timeline li:last-child::before{ display:none; }
@media (max-width:780px){ .timeline{ grid-template-columns:1fr; } .timeline li::before{ display:none; } }
```

### 7.7 رسم بياني SVG مضمن

```html
<figure class="chart">
  <svg viewBox="0 0 420 180" role="img" aria-label="نمو الإيرادات من 2023 إلى 2026">
    <g fill="var(--accent)">
      <rect x="24" y="100" width="56" height="56" rx="6" opacity=".3"/>
      <rect x="110" y="78" width="56" height="78" rx="6" opacity=".5"/>
      <rect x="196" y="52" width="56" height="104" rx="6" opacity=".75"/>
      <rect x="282" y="24" width="56" height="132" rx="6"/>
    </g>
    <line x1="12" y1="160" x2="408" y2="160" stroke="var(--border)" stroke-width="1.5"/>
    <g fill="var(--muted)" font-size="12" text-anchor="middle" font-family="var(--font-ui)">
      <text x="52" y="178">2023</text><text x="138" y="178">2024</text>
      <text x="224" y="178">2025</text><text x="310" y="178">2026</text>
    </g>
  </svg>
  <figcaption>الشكل 1: نمو الإيرادات (مليون ريال) — المصدر: الإدارة المالية.</figcaption>
</figure>
```

### 7.8 الوضع الليلي، الحركة، والطباعة

```css
@media (prefers-reduced-motion: reduce){ *{ animation:none !important; transition:none !important; } }

/* ظهور تدريجي خفيف عند التمرير (اختياري وليس إلزامياً) */
.reveal{ opacity:0; transform:translateY(12px); transition:opacity .5s ease, transform .5s ease; }
.reveal.in{ opacity:1; transform:none; }
/* إن عُطّل JS يجب ألا يختفي المحتوى */
@media (scripting: none){ .reveal{ opacity:1; transform:none; } }

@media print{
  :root{ --shadow-sm:none; --shadow-md:none; }
  .site-header,.btn,.nav{ display:none !important; }
  body{ background:#fff; color:#000; font-size:11pt; }
  .card,.kpi,.table-wrap{ break-inside:avoid; box-shadow:none; }
  .section{ padding-block:12mm; }
  a[href^="http"]::after{ content:" (" attr(href) ")"; font-size:9pt; color:#555; }
  @page{ size:A4; margin:16mm; }
}
```

### 7.9 التحقق بعد البناء (إلزامي)

1. افتح الصفحة والتقط لقطات شاشة (Playwright أو أداة المتصفح) بعرض **375px** و**768px** و**1440px**.
2. افحص: تمرير أفقي (`document.documentElement.scrollWidth > innerWidth`)، تدفّق النص، محاذاة RTL، تباين الألوان، حالات التمرير/التركيز.
3. اطبع إلى PDF مرة واحدة للتأكد من سلامة `@media print`.
4. افحص الطرفية: لا أخطاء 404 لصور/خطوط (أي مورد خارجي = مشكلة).

```js
// فحص سريع داخل المتصفح
console.log(document.documentElement.scrollWidth, window.innerWidth); // يجب scrollWidth <= innerWidth
```

---

## 8. العناصر البصرية: قواعد الاستخدام

| العنصر | متى | كيف |
|---|---|---|
| بطاقات KPI | أعلى التقرير | 3–4 بطاقات، رقم كبير `tabular-nums` + تسمية + سهم اتجاه |
| بطاقات خدمة | البروفايل/الخدمات | أيقونة في مربع بلون فاتح + عنوان + سطران وصف |
| جدول أنيق | البيانات التفصيلية | رأس غامق، صفوف متبادلة، شارات حالة، صف إجمالي |
| خط زمني | المنهجية/الخطة | دوائر مرقّمة + خط واصل + بطاقات نصية |
| قسم تمييز | إحصائية/اقتباس | خلفية `accent-soft` أو تدرّج واحد + نص كبير |
| SVG مضمن | الرسوم والأيقونات | `currentColor` ليتكيّف مع الوضع الليلي |
| شارة/Badge | الحالات | 3 حالات فقط: نجاح/تحذير/خطر بألوان متسقة |
| Divider | بين الأقسام | `border-block` أو `linear-gradient` رفيع |

ممنوع: أكثر من لون تمييز واحد، ظلال ثقيلة سوداء، حركة لا نهائية (pulse/parallax) في تقرير رسمي، أيقونات من مكتبات خارجية، نصوص فوق صور بلا طبقة تعتيم، 6 أحجام خطوط متقاربة (اختر سلّماً واضحاً).

---

## 9. أمثلة على أفضل الممارسات

**مثال 1 — رأس قسم مثالي**
```html
<section class="section" id="results">
  <div class="container">
    <p class="eyebrow">النتائج</p>
    <h2>أداء الربع الثالث 2026</h2>
    <p>سجّلت المؤشرات التشغيلية نمواً بنسبة 12.4% مقارنة بالربع السابق، مع تحسّن ملحوظ في زمن الاستجابة.</p>
    <div class="grid grid--3" style="margin-top:var(--s6)"> … بطاقات … </div>
  </div>
</section>
```

**مثال 2 — قبل/بعد**
- قبل: `<div>` بكل شيء، ألوان بنفسجية/حمراء عشوائية، جدول بحدود شبكية، خط 12px، لا استجابة، لا RTL صحيح.
- بعد: توكنات CSS، هيدر لاصق، Hero بعنوان `clamp`، بطاقات KPI، جدول بصفوف متبادلة وشارات، خط زمني، `@media print`، وضع ليلي تلقائي، SVG مضمن، تمرير أفقي صفري على 375px.

**مثال 3 — صفحة تقرير من 4 أقسام**
`hero` → `kpi (4 بطاقات)` → `results (جدول + رسم)` → `plan (خط زمني)` → `footer`. لا أكثر من 6 أقسام لصفحة تقرير واحدة.

---

## 10. أخطاء شائعة (تجنّبها)

1. Tailwind CDN أو خطوط Google Fonts → تفشل بلا إنترنت وفي المعاينات المعزولة.
2. نسيان `dir="rtl"` أو استخدام `left/right` بدل `inline-start/end`.
3. `letter-spacing` موجب على العربية → تفكيك الحروف.
4. ألوان HEX مباشرة في كل مكان بدل التوكنات → استحالة التعديل لاحقاً.
5. `grid-template-columns: repeat(3,1fr)` بلا استجابة → انهيار على الجوال.
6. `overflow-x` ناتج عن عنصر بعرض ثابت أو صورة كبيرة.
7. تباين ضعيف (نص رمادي فاتح على أبيض) — افحصه فعلياً.
8. حركة مستمرة أو مؤثرات ثقيلة تُشتّت في تقرير رسمي.
9. محتوى أساسي يُبنى في JS → لا يظهر إن عُطّل السكربت ويضرّ بأرشفة/طباعة.
10. تسليم بلا لقطات شاشة على three عروض → أخطاء تصميم لا تُكتشف أبداً.

---

## 11. قائمة التحقق النهائية قبل التسليم

- [ ] الأسئلة التسعة طُرحت، والإجابات كافية، والموجز مُعتمد.
- [ ] `<!DOCTYPE html>` + `lang="ar"` + `dir="rtl"` + `viewport` + `title` + `description`.
- [ ] كل CSS مضمّن/محلي والتوكنات مستخدمة — صفر موارد خارجية (أو مُعلنة للمستخدم صراحة).
- [ ] صفحة تعمل بلا إنترنت وبلا JS.
- [ ] استجابة مؤكدة على 375 / 768 / 1440px بلا تمرير أفقي.
- [ ] هيدر/Footer مكتملان، وكل رابط `#anchor` يعمل.
- [ ] بطاقات KPI + جدول/رسم بالحد الأدنى من العناصر البصرية المطلوبة.
- [ ] أيقونات SVG مضمنة بـ `currentColor`، ومقاسها متسق (16/20/24px).
- [ ] تباين ≥ 4.5:1، `:focus-visible` واضح، HTML دلالي (`header/main/section/footer`)، `alt` لكل صورة.
- [ ] وضع ليلي لا يكسر أي لون (فحص `prefers-color-scheme`).
- [ ] `prefers-reduced-motion` محترم.
- [ ] `@media print` نظيف ومُجرَّب (أُنتج PDF منه مرة).
- [ ] لقطات شاشة على المقاسات الثلاثة تمت مراجعتها بصرياً.
- [ ] اسم الملف واضح (`تقرير-الأداء-2026.html`) وحجمه معقول.
- [ ] سلّمت الملف + ملاحظة قصيرة عن كيفية تغيير الألوان/الخط عبر متغيّرات `:root`.
