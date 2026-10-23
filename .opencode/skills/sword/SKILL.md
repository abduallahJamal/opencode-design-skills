---
name: sword
description: Create and edit professional, visually rich Microsoft Word (.docx) documents with python-docx — branded cover pages, custom heading styles, styled tables, callout boxes, accent dividers, professional headers/footers with page fields, and full Arabic/RTL support. Use when the user asks for a Word file, .docx report, proposal, quotation, company profile, technical document, or any editable document deliverable.
license: MIT
compatibility: opencode
metadata:
  category: documents-design
  workflow: document-generation
  output: "Word (.docx) documents"
  stack: "python-docx"
  rtl: "true"
  version: "1.0.0"
---

# sword — إنشاء وتعديل ملفات Word احترافية

مهارة متخصصة في إنتاج ملفات `.docx` بمستوى بصري احترافي (لا تنسيق افتراضي)، مع دعم كامل للعربية واتجاه RTL، وقابلية تعديل عالية داخل Word.

---

## 1. متى تستخدم هذه المهارة

استخدمها عندما يطلب المستخدم:

- ملف Word أو `.docx` أو "مستند قابل للتعديل".
- تقرير، عرض سعر، عرض فني، كتيب تعريفي، بروفايل شركة، وثيقة تقنية، سياسة/إجراء، خطاب رسمي، سيرة ذاتية.
- تحويل محتوى (Markdown / نص / بيانات) إلى مستند Word منسّق.
- تعديل ملف `.docx` موجود: إعادة تنسيق، إضافة هوية بصرية، تصحيح اتجاه RTL، تحسين الجداول.

لا تستخدمها لملفات PDF النهائية (استخدم `spdf`) ولا لصفحات الويب (استخدم `shtml`). إذا احتاج المستخدم معاينة بصرية سريعة، ولّد Word ثم حوّله إلى PDF للمعاينة فقط.

---

## 2. القاعدة الذهبية: اسأل أولاً — إلزامي

> **ممنوع تماماً إنشاء الملف أو كتابة الكود قبل الحصول على إجابات كافية.**
> إذا بدأت التنفيذ قبل الأسئلة فأنت تخالف المهارة، حتى لو كان الطلب يبدو واضحاً.

### 2.1 البروتوكول

1. اسأل المستخدم **دفعة واحدة منظمة** (4–5 أسئلة كحد أقصى في الدفعة الأولى عبر أداة الأسئلة التفاعلية إن توفرت، وإلا فقائمة مرقمة واضحة).
2. اجمع الإجابات، ثم اسأل ما تبقّى في دفعة ثانية فقط إن كان جوهرياً.
3. لا تبدأ التنفيذ إلا بعد أن تكون كل نقطة من "الحد الأدنى الكافي" واضحة.
4. اكتب **موجز تصميم (Design Brief) من 5–7 أسطر** يعيد صياغة الإجابات، واطلب من المستخدم موافقة سريعة (نعم/عدّل).
5. بعد الموافقة: نفّذ، ثم ولّد معاينة PDF، ثم راجع بصرياً قبل التسليم.

### 2.2 الأسئلة الإلزامية (اسألها كلها بصياغة تناسب السياق)

1. **الهدف:** ما هو الهدف من المستند؟ (تقرير / عرض سعر / كتيب / وثيقة تقنية / بروفايل شركة / خطاب / أخرى) وما اسم المستند الرسمي؟
2. **الجمهور:** من هو الجمهور المستهدف؟ (إدارة عليا، عميل، جهة حكومية، فريق تقني، جمهور عام) — يحدد مستوى الرسمية وكثافة التفاصيل.
3. **الستايل:** هل تريد ستايلاً معيناً؟ (Minimal / Corporate / Modern Dark / ملون قوي / فاخر Luxury / حكومي رسمي).
4. **الألوان والهوية:** ما الألوان المفضلة أو هوية العلامة التجارية (كودات HEX أو وصف)؟ هل هناك خط شركة معتمد؟
5. **الشعار والصور:** هل لديك شعار أو صور تريد إضافتها؟ ما مساراتها؟ وإن لم توجد، هل أستخدم أيقونات/أشكال بديلة؟
6. **الحجم:** ما الحجم التقريبي أو عدد الصفحات المطلوب؟ (صفحة، 3–5، 10+، بلا حد)
7. **العناصر البصرية:** هل تريد جداول أو رسوم بيانية أو إنفوجرافيك؟ ما البيانات المتاحة لها؟
8. **المحتوى:** هل يوجد محتوى جاهز أم أكتبه من الصفر؟ إن كان جاهزاً فأرفقه أو أعطني مساره.
9. **تفاصيل إضافية:** اللغة (عربي / إنجليزي / مختلط)، الاتجاه (RTL/LTR)، الترويسة والتذييل (اسم الشركة، التاريخ، رقم الإصدار، الشعار)، سرية المستند، رقم الصفحات، أي متطلبات جهة خارجية (قالب مؤسسي، خطاب رسمي بترويسة).

### 2.3 الحد الأدنى الكافي قبل البدء

| العنصر | مقبول كافٍ |
|---|---|
| نوع المستند | محدد أو مُستنتج بثقة عالية من رسالة المستخدم |
| الجمهور والستايل | محددان أو موافَق على البدائل التي اقترحتها |
| الألوان | HEX محدد، أو "اختر لي" مع موافقة صريحة |
| المحتوى | مُرفق، أو موافقة على أن أكتبه |
| الصور | مسارات محددة، أو موافقة على العمل بدونها |

### 2.4 إن رفض المستخدم الإجابة

اقترح حزمة افتراضية صريحة (**Corporate عربي RTL، أزرق داكن + رمادي، Cairo/Dubai، هيكل 6 أقسام**) واطلب موافقة بكلمة واحدة قبل المتابعة. لا تفترض وتنفّذ بصمت.

---

## 3. جدول قرارات سريع (نوع المستند ← الهيكل)

| النوع | الغلاف | الهيكل المفضل | لمسات بصرية أساسية |
|---|---|---|---|
| تقرير | نعم | ملخص تنفيذي، فهرس، مقدمة، منهجية، نتائج (جداول + رسوم)، توصيات، ملاحق | مؤشرات KPI في جدول بطاقات، فواصل أقسام، جداول زebra |
| عرض سعر | نعم مختصر | ترسية/مقدمة، نطاق العمل، التسعير (جدول)، الشروط، التوقيع | جدول تسعير بارز، خانات بارزة للإجمالي |
| كتيب/بروفايل | نعم | من نحن، الرؤية، الخدمات (بطاقات)، الأرقام، المشاريع، تواصل | أرقام كبيرة، بطاقات خدمة، فاصل ملوّن |
| وثيقة تقنية | نعم | نظرة عامة، المتطلبات، الخطوات (مرقمة)، الجداول المرجعية، الأسئلة الشائعة | صناديق تنبيه (ملاحظة/تحذير/خطأ)، أكواد بخط أحادي |
| خطاب رسمي | لا | ترويسة، التاريخ/المرجع، الموضوع، النص، التوقيع | ترويسة مؤسسية + خط فاصل رفيع |
| سي في | لا | بيانات، ملخص، خبرة، تعليم، مهارات | عمود جانبي ملوّن، خط زمني |

---

## 4. المبادئ التصميمية (غير قابلة للتفاوض)

1. **هرمية بصرية صريحة:** لكل صفحة عنوان واضح، وفرق حجم/وزن محسوس بين H1 و H2 و H3 والنص.
2. **شبكة ومسافات مدروسة:** مسافات بيضاء منتظمة (8pt كوحدة أساس)، عدم حشو الصفحة، نص لا يلامس الهوامش.
3. **لون محايد + لون هوية واحد قوي + لون تمييز واحد:** لا أكثر من 3 ألوان وظيفية.
4. **كل عنصر بصري يحمل معنى:** لا زخرفة بلا وظيفة، ولا أيقونة داخل كل سطر.
5. **الاتساق قبل الإبداع:** نفس الغلاف، نفس الترويسة، نفس نمط الجداول في كل المستند.
6. **قابلية التعديل:** استخدم أنماط Word الحقيقية (Styles) لا تنسيقاً يدوياً عشوائياً، حتى يستطيع المستخدم تعديل المستند بسهولة.
7. **Bidi نظيف:** العربية RTL بالكامل؛ الأرقام والكلمات اللاتينية تُعرض بشكل صحيح داخل السطر العربي.
8. **لا تكديس أسطر يتيمة:** اضبط `keep_with_next` للعناوين ومنع كسر الجداول في منتصفها.

---

## 5. نظام التصميم: الألوان والخطوط

### 5.1 لوحات جاهزة (استخدم واحدة والتزم بها)

| اللوحة | Ink | Accent | Accent2 | Surface | Border | Muted |
|---|---|---|---|---|---|---|
| Corporate Blue | `0F172A` | `1D4ED8` | `0EA5A4` | `F8FAFC` | `E2E8F0` | `64748B` |
| Modern Dark | `0B1220` | `38BDF8` | `A78BFA` | `111827` | `1F2937` | `94A3B8` |
| Luxury | `1C1917` | `B08D57` | `7C2D12` | `FAF7F2` | `E7E1D8` | `78716C` |
| Government | `111827` | `0F766E` | `9A3412` | `F9FAFB` | `D1D5DB` | `6B7280` |
| Vibrant | `0F172A` | `7C3AED` | `F59E0B` | `FAF5FF` | `E9D5FF` | `6B7280` |

قواعد:
- النص الأساسي `Ink` أو `Body = 334155`؛ العناوين بلون العنصر القوي فقط عند الحاجة (لا تجعل كل العناوين ملوّنة).
- التدرجات اللونية غير مدعومة أصلاً في Word؛ **حاكِها** بشرائط لونية متتابعة (3–4 خلايا/فقرات بتدرّج من الفاتح إلى الغامق) أو بخلفية غامقة + نص أبيض.
- نسبة التباين ≥ 4.5:1 للنص العادي.

### 5.2 الخطوط

| الاستخدام | عربي | لاتيني | الحجم |
|---|---|---|---|
| عنوان الغلاف | Dubai / Tajawal / Amiri (فاخر) | Inter / Playfair | 28–34pt Bold |
| H1 قسم | Dubai / Cairo | Inter | 20–24pt Bold |
| H2 | Cairo / Dubai | Inter | 15–17pt Bold |
| H3 | Cairo | Inter | 12–13pt SemiBold |
| نص | Cairo / Dubai / Segoe UI | Inter / Calibri | 10.5–11.5pt |
| تسمية/تعليق | Cairo | Inter | 8.5–9pt Muted |
| أرقام KPI | Inter / Dubai | — | 24–32pt Bold |

قواعد حاسمة للعربية:
- يجب ضبط **الخط الثلاثي** لكل Run عربي: `w:rFonts` بخصائص `w:ascii` و `w:hAnsi` و **`w:cs`**، مع `w:szCs` بحجم نص مكافئ، وإلا يعود Word لخط افتراضي قبيح.
- لا تستخدم خطاً لا يحتوي محارف عربية (مثل Calibri فقط) للنص العربي.
- عرض السطر الأمثل 60–80 حرفاً؛ لا تبرّر النص العربي (`justify`) إن أنتج فراغات قبيحة — استخدم `right` أو `justifyLow` بحذر.
- تباعد الأسطر 1.3–1.5 للعربية.

### 5.3 المسافات والهوامش

- هوامش الصفحة (A4): أعلى/أسفل 2.2cm، يمين/يسار 2.0cm (RTL: اليمين هو بداية النص). مستند رسمي: 2.5cm.
- مسافة بعد الفقرة: 6–8pt. مسافة قبل H1: 18pt، بعد H2: 6pt.
- حشو خلايا الجدول: 80–120 twips رأسياً وأفقياً.
- استخدم `WD_SECTION.NEW_PAGE` لفصل الأقسام الكبرى، لا أسطر فارغة متكررة.

---

## 6. هيكل المستند المفضل

1. **صفحة الغلاف:** شريط لوني علوي/سفلي، شعار (إن وُجد)، عنوان كبير، سطر وصفي، اسم الجهة، التاريخ، رقم الإصدار، تصنيف السرية. بلا ترويسة/تذييل على الغلاف.
2. **صفحة المعلومات/الفهرس:** جدول بيانات المستند (الجهة، المُعد، المراجع، الإصدار، التاريخ) + فهرس يدوي منسّق (بأرقام صفحات) أو حقل TOC حقيقي.
3. **الملخص التنفيذي:** صندوق بارز + 3–5 نقاط نتائج.
4. **الأقسام الرئيسية:** عنوان H1 مع فاصل لوني تحته، مقدمة قصيرة، ثم محتوى منظم (نص/جداول/بطاقات).
5. **العناصر البصرية:** كل جدول/رسم مع عنوان (Caption) ورقم ومصدر.
6. **الخاتمة/التوصيات:** قائمة مرقمة قابلة للتنفيذ.
7. **الملاحق:** جداول مرجعية، مصطلحات، مراجع.
8. **صفحة الختام/التواصل:** شعار، بيانات تواصل، QR اختياري.

قواعد الترويسة والتذييل:
- الترويسة: شعار صغير يمين + اسم المستند وسط/يسار + خط فاصل سفلي رفيع (1pt) بلون الهوية.
- التذييل: اسم الجهة يمين، رقم الصفحة «صفحة X من Y» يسار (LTR) أو معكوس في RTL، سطر السرية بخط صغير Muted.
- الغلاف بلا ترويسة/تذييل: استخدم `section.different_first_page_header_footer = True`.

---

## 7. الوصفة التقنية (python-docx)

### 7.1 التثبيت والأساسيات

```bash
pip install python-docx pillow
# للمعاينة والتحقق:
which libreoffice soffice 2>/dev/null || echo "NO_SOFFICE"
```

```python
from docx import Document
from docx.shared import Pt, Cm, RGBColor, Emu
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_LINE_SPACING
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.section import WD_SECTION
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
```

### 7.2 تفعيل RTL على مستوى المستند والفقرة والنص (إلزامي)

```python
def rtl_section(section):
    sectPr = section._sectPr
    bidi = OxmlElement('w:bidi')                     # اتجاه القسم RTL
    sectPr.append(bidi)

def rtl_paragraph(p, align=WD_ALIGN_PARAGRAPH.RIGHT):
    p.alignment = align
    pPr = p._p.get_or_add_pPr()
    if pPr.find(qn('w:bidi')) is None:
        pPr.append(OxmlElement('w:bidi'))
    for r in p.runs:
        rPr = r._element.get_or_add_rPr()
        if rPr.find(qn('w:rtl')) is None:
            el = OxmlElement('w:rtl'); el.set(qn('w:val'), '1'); rPr.append(el)

def ar_run(p, text, font="Dubai", size=11, bold=False, color="334155"):
    r = p.add_run(text)
    r.font.size = Pt(size)
    r.bold = bold
    r.font.color.rgb = RGBColor.from_string(color)
    rPr = r._element.get_or_add_rPr()
    rFonts = rPr.find(qn('w:rFonts')) or OxmlElement('w:rFonts')
    rFonts.set(qn('w:ascii'), font); rFonts.set(qn('w:hAnsi'), font); rFonts.set(qn('w:cs'), font)
    if rFonts.getparent() is None:
        rPr.append(rFonts)
    szCs = OxmlElement('w:szCs'); szCs.set(qn('w:val'), str(int(size * 2))); rPr.append(szCs)
    rtl = OxmlElement('w:rtl'); rtl.set(qn('w:val'), '1'); rPr.append(rtl)
    return r
```

### 7.3 أنماط Heading مخصصة (استخدم Styles لا التنسيق اليدوي)

```python
from docx.enum.style import WD_STYLE_TYPE

def define_heading(doc, name, size, color, bold=True, space_before=18, space_after=6):
    st = doc.styles[name]
    st.font.name = "Dubai"; st.font.size = Pt(size); st.font.bold = bold
    st.font.color.rgb = RGBColor.from_string(color)
    st.paragraph_format.space_before = Pt(space_before)
    st.paragraph_format.space_after = Pt(space_after)
    st.paragraph_format.keep_with_next = True
    st.paragraph_format.line_spacing = 1.25
    # الخط العربي + RTL على مستوى النمط
    rPr = st.element.get_or_add_rPr()
    rFonts = rPr.get_or_add_rFonts()
    rFonts.set(qn('w:cs'), "Dubai")
    szCs = OxmlElement('w:szCs'); szCs.set(qn('w:val'), str(int(size * 2))); rPr.append(szCs)
    pPr = st.element.get_or_add_pPr()
    pPr.append(OxmlElement('w:bidi'))

define_heading(doc, 'Heading 1', 22, '0F172A')
define_heading(doc, 'Heading 2', 16, '1D4ED8')
define_heading(doc, 'Heading 3', 12.5, '334155', space_before=10, space_after=4)
```

### 7.4 فاصل بصري (خط تحتي بلون الهوية)

```python
def rule(p, color="1D4ED8", size=12, space=6):
    pPr = p._p.get_or_add_pPr()
    pbdr = OxmlElement('w:pBdr')
    bottom = OxmlElement('w:bottom')
    bottom.set(qn('w:val'), 'single'); bottom.set(qn('w:sz'), str(size))
    bottom.set(qn('w:space'), str(space)); bottom.set(qn('w:color'), color)
    pbdr.append(bottom); pPr.append(pbdr)
```

### 7.5 ترويسة وتذييل احترافيان + حقول الصفحات

```python
def field(p, instr, font="Inter", size=8.5, color="64748B"):
    r = p.add_run()
    r.font.size = Pt(size); r.font.color.rgb = RGBColor.from_string(color)
    f1 = OxmlElement('w:fldChar'); f1.set(qn('w:fldCharType'), 'begin')
    it = OxmlElement('w:instrText'); it.set(qn('xml:space'), 'preserve'); it.text = instr
    f2 = OxmlElement('w:fldChar'); f2.set(qn('w:fldCharType'), 'separate')
    t  = OxmlElement('w:t'); t.text = "1"
    f3 = OxmlElement('w:fldChar'); f3.set(qn('w:fldCharType'), 'end')
    for el in (f1, it, f2, t, f3):
        r._r.append(el)

section = doc.sections[0]
section.different_first_page_header_footer = True     # غلاف نظيف
hdr = section.header.paragraphs[0]
ar_run(hdr, "اسم الجهة", font="Dubai", size=9, color="0F172A")
hdr.add_run("\t")
ar_run(hdr, "تقرير المشروع — 2026", size=8.5, color="64748B")
rule(hdr, color="E2E8F0", size=6)

ftr = section.footer.paragraphs[0]
ar_run(ftr, "سري — للاستخدام الداخلي", size=8, color="94A3B8")
ftr.add_run("\t")
ar_run(ftr, "صفحة ", size=8.5, color="64748B"); field(ftr, "PAGE")
ar_run(ftr, " من ", size=8.5, color="64748B"); field(ftr, "NUMPAGES")
```

### 7.6 جداول أنيقة (بلا حدود، رأس ملوّن، صفوف متبادلة)

```python
def shade(cell, hexcolor):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = OxmlElement('w:shd')
    shd.set(qn('w:val'), 'clear'); shd.set(qn('w:color'), 'auto'); shd.set(qn('w:fill'), hexcolor)
    tcPr.append(shd)

def table_borders(table, color="E2E8F0", size=4, inside=True):
    tbl = table._tbl
    tblPr = tbl.tblPr
    borders = OxmlElement('w:tblBorders')
    edges = ['top', 'left', 'bottom', 'right'] + (['insideH', 'insideV'] if inside else [])
    for edge in ['top', 'left', 'bottom', 'right', 'insideH', 'insideV']:
        el = OxmlElement(f'w:{edge}')
        if edge in edges:
            el.set(qn('w:val'), 'single'); el.set(qn('w:sz'), str(size))
            el.set(qn('w:color'), color)
        else:
            el.set(qn('w:val'), 'nil')
        borders.append(el)
    tblPr.append(borders)

def cell_pad(cell, top=90, bottom=90, left=140, right=140):
    tcPr = cell._tc.get_or_add_tcPr()
    mar = OxmlElement('w:tcMar')
    for tag, val in (('top', top), ('bottom', bottom), ('start', left), ('end', right)):
        el = OxmlElement(f'w:{tag}'); el.set(qn('w:w'), str(val)); el.set(qn('w:type'), 'dxa'); mar.append(el)
    tcPr.append(mar)

# بناء الجدول + تكرار الرأس على الصفحات التالية
tbl = doc.add_table(rows=1, cols=3)
tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
tbl.style = 'Table Grid'
table_borders(tbl)
# RTL للجدول (ترتيب الأعمدة يبدأ من اليمين)
tbl._tbl.tblPr.append(OxmlElement('w:bidiVisual'))
hdr_row = tbl.rows[0]
for cell, label in zip(hdr_row.cells, ["البند", "الكمية", "الإجمالي"]):
    shade(cell, "0F172A"); cell_pad(cell)
    p = cell.paragraphs[0]; rtl_paragraph(p)
    ar_run(p, label, size=9.5, bold=True, color="FFFFFF")
# تكرار صف الرأس
trPr = hdr_row._tr.get_or_add_trPr()
tblHeader = OxmlElement('w:tblHeader'); tblHeader.set(qn('w:val'), 'true'); trPr.append(tblHeader)
```

للصفوف المتناوبة: `shade(cell, "F8FAFC")` للصفوف الزوجية فقط، والصفوف الفردية بلا تعبئة.

### 7.7 صناديق نص ملوّنة (Callout) — عبر جدول 1×1

> ملاحظة تقنية: صناديق النص (Text Boxes) في Word غير مستقرة عبر المحرّرات. البديل الاحترافي ثلاثي:
> **جدول 1×1** بخلفية فاتحة + حدّ جانبي سميك بلون التنبيه. هذا آمن، يُطبع، ولا يتحرك.

```python
def callout(doc, title, body, accent="1D4ED8", fill="EFF6FF", icon="●"):
    t = doc.add_table(rows=1, cols=1)
    t.autofit = True
    t._tbl.tblPr.append(OxmlElement('w:bidiVisual'))
    cell = t.cell(0, 0)
    shade(cell, fill); cell_pad(cell, 160, 160, 200, 200)
    # حدود: جانبية فقط بلون التنبيه (يمين = بداية النص في RTL)
    tcPr = cell._tc.get_or_add_tcPr()
    b = OxmlElement('w:tcBorders')
    for edge, sz, col in (('start', 36, accent), ('top', 0, fill), ('bottom', 0, fill), ('end', 0, fill)):
        el = OxmlElement(f'w:{edge}')
        if sz:
            el.set(qn('w:val'), 'single'); el.set(qn('w:sz'), str(sz)); el.set(qn('w:color'), col)
        else:
            el.set(qn('w:val'), 'nil')
        b.append(el)
    tcPr.append(b)
    p1 = cell.paragraphs[0]; rtl_paragraph(p1)
    ar_run(p1, f"{icon}  {title}", size=11, bold=True, color=accent)
    p2 = cell.add_paragraph(); rtl_paragraph(p2)
    ar_run(p2, body, size=10.5, color="334155")
    doc.add_paragraph().paragraph_format.space_after = Pt(4)
```

أنواع الصناديق: ملاحظة (`1D4ED8`/`EFF6FF`)، تحذير (`B45309`/`FFFBEB`)، خطأ (`B91C1C`/`FEF2F2`)، نجاح (`15803D`/`F0FDF4`).

### 7.8 صفحات الغلاف وحقول الفهرس

```python
section.page_width, section.page_height = Cm(21), Cm(29.7)
section.top_margin = section.bottom_margin = Cm(2.2)
section.left_margin = section.right_margin = Cm(2.0)

# فهرس حقيقي (يطلب من Word تحديث الحقول عند الفتح)
p = doc.add_paragraph(); rtl_paragraph(p)
fld = OxmlElement('w:fldSimple'); fld.set(qn('w:instr'), 'TOC \\o "1-2" \\h \\z \\u')
p._p.append(fld)
# والفهرس اليدوي المنسّق أفضل للنواتج الجاهزة للطباعة
```

بعد التوليد، إن أردت أرقام صفحات دقيقة في الفهرس، حوّل إلى PDF واستخرج عناوين الأقسام وصفحاتها ثم ابنِ الفهرس يدوياً.

### 7.9 الصور والشعارات

```python
doc.add_picture("logo.png", width=Cm(3.2))
# داخل جداول البطاقات: قصّ دائري غير مدعوم — استخدم PNG شفافاً أو أيقونات SVG محوّلة إلى PNG
```
- حوّل SVG إلى PNG عبر `cairosvg` أو `rsvg-convert` قبل الإدراج.
- للرسوم البيانية: `matplotlib` مع خط عربي مسجّل، `dpi=200`, `figsize=(7,3.5)`، بلا إطار، ألوان من اللوحة، وحفظ `transparent=False` بخلفية بيضاء.

### 7.10 التحقق الإلزامي بعد التوليد

```bash
soffice --headless --convert-to pdf out.docx --outdir preview
pdftoppm -png -r 80 preview/out.pdf preview/page   # راجع الصور بصرياً
```
افحص: هل يوجد عنوان يتيم في أسفل صفحة؟ هل انكسر جدول؟ هل العربية مقلوبة أو بخط افتراضي؟ هل الغلاف نظيف بلا ترويسة؟ هل أرقام الصفحات تعمل؟

---

## 8. العناصر البصرية: قواعد الاستخدام

| العنصر | متى | كيف |
|---|---|---|
| شريط لوني | الغلاف، رؤوس الأقسام | فقرة/جدول بارتفاع ~0.3cm بتعبئة صلبة |
| بطاقات KPI | أرقام رئيسية | جدول 3–4 أعمدة، كل خلية بخلفية `F8FAFC` + رقم كبير + تسمية صغيرة |
| أيقونات | بنود القوائم، بطاقات الخدمات | PNG أحادي اللون 32–48px بلون الهوية، أو رمز Unicode بسيط (✓ ● ▲) بلا إفراط |
| إنفوجرافيك بسيط | العمليات، الخط الزمني | جدول أفقي بأعمدة مرقّمة + أسهم `→`، أو مخطط matplotlib |
| صورة غلاف | التقارير التسويقية | شريط عريض أعلى الغلاف مع تعتيم خفيف ونص أبيض |
| فاصل قسم | بين الأقسام الكبرى | سطر فارغ + `rule()` بلون فاتح + مسافة |

ممنوع: أكثر من 3 أيقونات في فقرة، تعبئة خلايا بألوان صارخة للنص الطويل، ظلال/تأثيرات Word القديمة (WordArt, Reflection).

---

## 9. أمثلة على أفضل الممارسات

**مثال 1 — عنوان قسم احترافي**
```
H1 (22pt, Ink, Bold)  ←  «الثاني: نتائج التحليل»
   سطر وصفي 10.5pt Muted: «يعرض هذا القسم مؤشرات الأداء للربع الثالث مقارنة بالمستهدف.»
   ────────────── خط لون الهوية 1.5pt بعرض الصفحة
```

**مثال 2 — جدول تسعير بدل جدول افتراضي**
- رأس غامق `0F172A` بنص أبيض 9.5pt.
- أعمدة: البند | الوصف | الكمية | سعر الوحدة | الإجمالي.
- أرقام بمحاذاة يسار (LTR) داخل خلية RTL.
- صف الإجمالي: خلفية `EFF6FF` + نص عريض + حد أعلى 2pt.
- سطر ملاحظة أسفل الجدول 8.5pt Muted: «الأسعار لا تشمل ضريبة القيمة المضافة.»

**مثال 3 — قبل/بعد**
- قبل: نص كله 11pt أسود، عناوين Bold يدوياً، جدول `Table Grid` افتراضي، بلا ترويسة.
- بعد: أنماط Heading معرّفة، غلاف بلون الهوية، ترويسة بشعار وخط فاصل، جداول بلا حدود عمودية مع رأس ملوّن وتعبئة متبادلة، صناديق تنبيه للتحذيرات، تذييل بترقيم.

---

## 10. أخطاء شائعة (تجنّبها)

1. نسيان `w:cs` و `w:szCs` → العربية تظهر بخط افتراضي مختلف عن العناوين.
2. نسيان `w:bidi` في الفقرة → علامات الترقيم في المكان الخطأ.
3. الاعتماد على `Table Grid` الافتراضي → مظهر غير احترافي فوراً.
4. استخدام Text Boxes → يتحرك المحتوى بين نسخ Word/LibreOffice.
5. أسطر فارغة متعددة للمسافات → صفحات مشوّهة؛ استخدم `space_before/after`.
6. جداول تنكسر بين صفحتين بلا رأس متكرر.
7. غلاف يحمل ترويسة ورقم صفحة.
8. تدرّجات وظلال مرسومة يدوياً → لا تُنتج في Word؛ حاكِها بشرائط.
9. محتوى بلا مصدر للأرقام في تقرير رسمي.
10. ملف بلا مراجعة بصرية → أخطاء اتجاه لا تُكتشف إلا بالنظر.

---

## 11. قائمة التحقق النهائية قبل التسليم

- [ ] طرحت الأسئلة التسعة وحصلت على إجابات كافية، ووافق المستخدم على الموجز.
- [ ] الستايل واللوحة اللونية موحّدان في كل الصفحات.
- [ ] العربية RTL صحيحة: الفقرات، الجداول (`bidiVisual`)، الترويسة، التذييل.
- [ ] الخطوط العربية مضبوطة على `ascii/hAnsi/cs` + `szCs`.
- [ ] غلاف احترافي بلا ترويسة/تذييل، وفيه الجهة والتاريخ والإصدار.
- [ ] أنماط Heading معرّفة ومستخدمة (لا تنسيق يدوي عشوائي).
- [ ] جداول: رأس ملوّن، حشو، صفوف متبادلة، رأس متكرر، صف إجمالي بارز عند الحاجة.
- [ ] صناديق تنبيه/ملاحظات مستخدمة بحد جانبي ملوّن.
- [ ] تذييل بترقيم صفحات (PAGE/NUMPAGES) يعمل، وترويسة بخط فاصل رفيع.
- [ ] لا عناوين يتيمة، لا جداول مكسورة، لا صفحات شبه فارغة.
- [ ] الرسوم البيانية بخط عربي واضح، بعنوان ورقم ومصدر.
- [ ] تم التحويل إلى PDF ومراجعة الصفحات بصرياً.
- [ ] اسم الملف واضح ومنطقي (`تقرير-اسم-المشروع-2026.docx`)، وحجم الملف معقول.
- [ ] سلّمت الملف + ملاحظات قصيرة عن كيفية تعديل الألوان/الخطوط داخل Word.
