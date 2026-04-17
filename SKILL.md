---
name: narikiri
description: Rewrite the user's content in a target voice/style while preserving the original meaning — 体制内汇报风, 毕业答辩风, 阴阳怪气风, 小红书风, 鲁迅风, 商务邮件风, LinkedIn humblebrag, 日语敬语, and more. Accepts input in any language and outputs in a user-specified language (default = same as input). Use when the user says "把这段改成 X 风格", "用 X 的腔调写", "make this sound like a LinkedIn post / thesis defense / bureaucratic report", "帮我写得更像领导讲话 / 更阴阳怪气 / 更学术", or any request to restyle / reshape / cosplay existing content. This is style transformation, NOT translation — though it can restyle across languages.
---

# narikiri — なりきり

Cosplay for text. Take the user's content and rewrite it in a target voice/style while preserving the core meaning.

## Core workflow

### 1. Collect inputs

- **Source content** — the text to rewrite
- **Target style(s)** — one or more, from the catalog below, or a custom style the user describes
- **Output language** — default = same as input; honor override ("用英文", "日本語で")
- **Length preference** — default = natural length of the target style; honor override

If source content or target style is missing, ask briefly (one question, not multiple).

### 2. Select style(s) and load reference

**Preset catalog** — when a listed style is requested, read the matching reference:

| Style family | Examples | Reference |
|---|---|---|
| 汉语官方体 | 体制内汇报风、新闻联播风、领导讲话风、八股文 | [chinese-official.md](references/chinese-official.md) |
| 学术体 | 毕业答辩风、学术论文风、文献综述风 | [academic.md](references/academic.md) |
| 阴阳怪气 / 毒舌 | 阴阳怪气风、毒舌评论风、反讽风 | [sarcastic.md](references/sarcastic.md) |
| 互联网风 | 小红书风、微商风、互联网黑话、推特风、Reddit风 | [internet.md](references/internet.md) |
| 文学体 | 鲁迅风、文言文风、朋友圈文艺风、煽情鸡汤风 | [literary.md](references/literary.md) |
| 商务体 | 商务邮件风、律师函风、客服道歉风、LinkedIn humblebrag | [business.md](references/business.md) |
| 日语体 | 敬語 / 商务日语 / ビジネスメール | [japanese.md](references/japanese.md) |

**Custom style**: If the user describes a style not in the catalog (e.g. "像我妈发家庭群", "像 GPT-3 刚出来时那种回答"), skip loading and analyze the style's features yourself before rewriting.

### 3. Extract the core message

Strip the user's current wording and identify **what they're actually trying to say**. This is the invariant that must survive restyling.

Example — input: "搞完了" → core: "工作已完成"
Example — input: "这个方案我觉得还可以再想想" → core: "此方案尚需改进"

If the input is long (>3 sentences), identify 2–5 key points and preserve all of them.

### 4. Apply the style

A style = a coordinated bundle of surface features:

- **Vocabulary register** — 正式 / 口语 / 专业术语 / 网络流行语 / 古文 / 方言
- **Sentence structure** — 长句堆叠 / 短句排比 / 倒装 / 省略 / 对偶
- **Rhetorical devices** — 引用 / 反问 / 排比 / 堆叠形容词 / 反讽
- **Emotional tenor** — 中立 / 激昂 / 冷讽 / 谦卑 / 撒娇 / 居高临下
- **Lexical tells** — 这个风格的**标志性词汇**（如 "统筹推进" / "深感荣幸" / "不破不立" / "家人们谁懂啊"）
- **Punctuation / emoji habit** — 严谨 → 句号；网感 → 感叹号 + emoji；古文 → 不用标点

**Rule**: match the style **fully or not at all**. 半官半俗 读起来最假。所有 feature 要一起切换。

### 5. Output

```
【原意】
<1 sentence summary of the preserved core claim>

【风格：X】
<the rewritten content>
```

When user asks for multiple styles, one block per style. When user wants extended comparison, optionally add 【改写要点】 showing which surface features were applied.

## Multilingual behavior

- **Output language follows input unless user says otherwise.**
- When restyling in a non-Chinese language, use that language's native equivalents — 英语"阴阳怪气" 要用英语特有的 passive-aggressive 话术（"as per my last email", "per my understanding"），不是把中文网络梗直译过去。
- When the style is language-locked (e.g. 文言文 only makes sense in Chinese; Japanese 敬語 only in Japanese), tell the user if they requested a mismatch and suggest a target-language equivalent.

## Principles

- **Preserve meaning.** Style swap ≠ fact swap. "报告没写完" 不能改写成"报告已顺利完成"。如果风格本身要求"粉饰"（如体制内汇报），可以**弱化负面**，但不能反转事实。
- **Commit fully to the style.** A half-hearted imitation is worse than no imitation. If doing 鲁迅风, use 鲁迅 的句式和词汇，不要中途破功。
- **Don't moralize the style.** User wants 阴阳怪气 → write sharp sarcasm seriously; don't preach "这样不好". User's choice.
- **Respect natural length.** 体制内汇报 往往铺垫较长；推特要压短。不要机械保持原字数。
- **If a style is ambiguous, offer variants.** 用户只说"写得好一点"时，给 2–3 个风格选项让 ta 挑，不要瞎猜。
- **Never claim something you didn't verify.** 不要在改写中**加入原文没有的事实** / 数字 / 引用。如果风格需要具体性而原文没有，用模糊占位（"相关数据"）而不是编造。

## Style vs. translation

This skill is **style transformation**, not translation. If user asks "把这段日语翻译成中文", that's pure translation — say so and offer to restyle too ("要不要同时改成 X 风格?"). Only do bare translation if user confirms.

Restyling **plus** translating is fine: e.g. "把这句中文改成 LinkedIn 英文风格". This is native to the skill.
