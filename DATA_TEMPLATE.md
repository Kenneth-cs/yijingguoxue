# 数据模板与示例

本文档提供数据文件的详细模板和示例，帮助快速准备应用所需的数据。

## 目录
1. [六十四卦数据模板](#六十四卦数据模板)
2. [八卦数据模板](#八卦数据模板)
3. [题库数据模板](#题库数据模板)
4. [数据整理工具](#数据整理工具)

---

## 六十四卦数据模板

### hexagrams.json

```json
[
  {
    "id": 1,
    "name": "乾",
    "chineseName": "乾为天",
    "upperTrigram": "乾",
    "lowerTrigram": "乾",
    "binary": "111111",
    "symbol": "☰☰",
    "description": "乾：元，亨，利，贞。",
    "interpretation": "乾卦象征天，代表刚健、积极进取的力量。元、亨、利、贞是四种根本德行，分别代表创始、亨通、和谐、坚贞。此卦鼓励人们以天的刚健之德自强不息。",
    "lines": [
      {
        "position": 1,
        "text": "初九：潜龙勿用。",
        "interpretation": "处于最下位的阳爻，象征龙还潜伏在水中，时机未到，不宜有所作为，应该韬光养晦，积蓄力量。"
      },
      {
        "position": 2,
        "text": "九二：见龙在田，利见大人。",
        "interpretation": "龙出现在田野上，象征才能开始显露，此时适合寻求德高望重者的指导，有利于事业发展。"
      },
      {
        "position": 3,
        "text": "九三：君子终日乾乾，夕惕若，厉无咎。",
        "interpretation": "君子整天勤奋努力，即使到了晚上也保持警惕，虽然处境艰难，但因为小心谨慎而无灾祸。"
      },
      {
        "position": 4,
        "text": "九四：或跃在渊，无咎。",
        "interpretation": "或者跃起，或者退回深渊，进退灵活，根据形势而动，所以没有过错。"
      },
      {
        "position": 5,
        "text": "九五：飞龙在天，利见大人。",
        "interpretation": "飞龙在天，象征事业达到巅峰，此时最适合发挥才能，与贤德之人相遇，大有作为。"
      },
      {
        "position": 6,
        "text": "上九：亢龙有悔。",
        "interpretation": "龙飞得过高，物极必反，会有悔恨。提醒人们要适可而止，不可过度。"
      }
    ]
  },
  {
    "id": 2,
    "name": "坤",
    "chineseName": "坤为地",
    "upperTrigram": "坤",
    "lowerTrigram": "坤",
    "binary": "000000",
    "symbol": "☷☷",
    "description": "坤：元，亨，利牝马之贞。君子有攸往，先迷后得主，利西南得朋，东北丧朋。安贞吉。",
    "interpretation": "坤卦象征地，代表柔顺、包容、承载的力量。如母马般柔顺坚贞，君子前行应先柔后刚，西南方得到朋友支持，东北方失去朋友，保持安定坚贞则吉祥。",
    "lines": [
      {
        "position": 1,
        "text": "初六：履霜，坚冰至。",
        "interpretation": "踩到霜就知道坚冰即将到来，提醒人们见微知著，防患于未然。"
      },
      {
        "position": 2,
        "text": "六二：直，方，大，不习无不利。",
        "interpretation": "正直、方正、宽大，即使不学习也无往不利，象征地德的厚重和包容。"
      },
      {
        "position": 3,
        "text": "六三：含章可贞，或从王事，无成有终。",
        "interpretation": "蕴含美德而能坚守，如果辅佐君王，虽不居功但能善终。"
      },
      {
        "position": 4,
        "text": "六四：括囊，无咎无誉。",
        "interpretation": "收紧口袋，谨言慎行，虽然没有赞誉，但也没有过错。"
      },
      {
        "position": 5,
        "text": "六五：黄裳，元吉。",
        "interpretation": "黄色的衣裳，黄色居中，象征中庸之道，大吉大利。"
      },
      {
        "position": 6,
        "text": "上六：龙战于野，其血玄黄。",
        "interpretation": "龙在原野上争斗，血流成河，阴气过盛则会物极必反，与阳相争。"
      }
    ]
  }
  // ... 其余62卦，格式相同
]
```

### 完整卦序参考

| 卦序 | 卦名 | 上卦 | 下卦 | 二进制 |
|------|------|------|------|--------|
| 1 | 乾 | 乾 | 乾 | 111111 |
| 2 | 坤 | 坤 | 坤 | 000000 |
| 3 | 屯 | 坎 | 震 | 010001 |
| 4 | 蒙 | 艮 | 坎 | 100010 |
| 5 | 需 | 坎 | 乾 | 010111 |
| 6 | 讼 | 乾 | 坎 | 111010 |
| 7 | 师 | 坤 | 坎 | 000010 |
| 8 | 比 | 坎 | 坤 | 010000 |
| ... | ... | ... | ... | ... |

*完整64卦列表参见易经典籍*

---

## 八卦数据模板

### trigrams.json

```json
[
  {
    "id": "qian",
    "name": "乾",
    "binary": "111",
    "element": "金",
    "direction": "西北",
    "symbolism": "天",
    "nature": "刚健",
    "family": "父",
    "description": "乾为天，三阳爻，纯阳之卦。象征天的刚健、积极、向上的力量。在自然界代表天，在家庭中代表父亲，性质刚健不息。",
    "attributes": {
      "season": "秋冬之交",
      "time": "戌亥",
      "color": "大赤",
      "animal": "马",
      "body": "首"
    }
  },
  {
    "id": "kun",
    "name": "坤",
    "binary": "000",
    "element": "土",
    "direction": "西南",
    "symbolism": "地",
    "nature": "柔顺",
    "family": "母",
    "description": "坤为地，三阴爻，纯阴之卦。象征地的柔顺、承载、包容的力量。在自然界代表大地，在家庭中代表母亲，性质柔顺厚德。",
    "attributes": {
      "season": "夏秋之交",
      "time": "未申",
      "color": "黄",
      "animal": "牛",
      "body": "腹"
    }
  },
  {
    "id": "zhen",
    "name": "震",
    "binary": "001",
    "element": "木",
    "direction": "东",
    "symbolism": "雷",
    "nature": "动",
    "family": "长男",
    "description": "震为雷，一阳爻在二阴爻之下。象征雷的震动、奋起的力量。在自然界代表雷电，在家庭中代表长子，性质主动。",
    "attributes": {
      "season": "春",
      "time": "卯",
      "color": "青",
      "animal": "龙",
      "body": "足"
    }
  },
  {
    "id": "xun",
    "name": "巽",
    "binary": "110",
    "element": "木",
    "direction": "东南",
    "symbolism": "风",
    "nature": "入",
    "family": "长女",
    "description": "巽为风，一阴爻在二阳爻之下。象征风的渐进、温和的力量。在自然界代表风，在家庭中代表长女，性质柔和渐进。",
    "attributes": {
      "season": "春夏之交",
      "time": "辰巳",
      "color": "白",
      "animal": "鸡",
      "body": "股"
    }
  },
  {
    "id": "kan",
    "name": "坎",
    "binary": "010",
    "element": "水",
    "direction": "北",
    "symbolism": "水",
    "nature": "陷",
    "family": "中男",
    "description": "坎为水，一阳爻在二阴爻之间。象征水的流动、险陷的力量。在自然界代表水，在家庭中代表中子，性质险陷流动。",
    "attributes": {
      "season": "冬",
      "time": "子",
      "color": "黑",
      "animal": "豕",
      "body": "耳"
    }
  },
  {
    "id": "li",
    "name": "离",
    "binary": "101",
    "element": "火",
    "direction": "南",
    "symbolism": "火",
    "nature": "丽",
    "family": "中女",
    "description": "离为火，一阴爻在二阳爻之间。象征火的光明、附丽的力量。在自然界代表火、日，在家庭中代表中女，性质光明附着。",
    "attributes": {
      "season": "夏",
      "time": "午",
      "color": "赤",
      "animal": "雉",
      "body": "目"
    }
  },
  {
    "id": "gen",
    "name": "艮",
    "binary": "100",
    "element": "土",
    "direction": "东北",
    "symbolism": "山",
    "nature": "止",
    "family": "少男",
    "description": "艮为山，一阳爻在二阴爻之上。象征山的静止、稳重的力量。在自然界代表山，在家庭中代表少子，性质静止稳定。",
    "attributes": {
      "season": "冬春之交",
      "time": "丑寅",
      "color": "黄",
      "animal": "狗",
      "body": "手"
    }
  },
  {
    "id": "dui",
    "name": "兑",
    "binary": "011",
    "element": "金",
    "direction": "西",
    "symbolism": "泽",
    "nature": "说",
    "family": "少女",
    "description": "兑为泽，一阴爻在二阳爻之上。象征泽的喜悦、言说的力量。在自然界代表湖泊沼泽，在家庭中代表少女，性质喜悦和顺。",
    "attributes": {
      "season": "秋",
      "time": "酉",
      "color": "白",
      "animal": "羊",
      "body": "口"
    }
  }
]
```

---

## 题库数据模板

### quiz_questions.json

```json
[
  {
    "id": 1,
    "category": "基础知识",
    "difficulty": "easy",
    "question": "易经中第一卦是什么？",
    "options": [
      "乾卦",
      "坤卦",
      "屯卦",
      "蒙卦"
    ],
    "correctAnswer": "乾卦",
    "explanation": "乾卦是易经六十四卦中的第一卦，象征天，代表刚健的力量。"
  },
  {
    "id": 2,
    "category": "基础知识",
    "difficulty": "easy",
    "question": "八卦中代表地的是哪一卦？",
    "options": [
      "乾",
      "坤",
      "震",
      "巽"
    ],
    "correctAnswer": "坤",
    "explanation": "坤卦象征地，代表柔顺、承载的力量，与乾卦相对应。"
  },
  {
    "id": 3,
    "category": "卦象识别",
    "difficulty": "medium",
    "question": "由两个坎卦组成的重卦是？",
    "options": [
      "坎卦",
      "习坎",
      "蹇卦",
      "解卦"
    ],
    "correctAnswer": "习坎",
    "explanation": "习坎又称重坎，由两个坎卦叠加而成，象征重重险难。"
  },
  {
    "id": 4,
    "category": "卦辞理解",
    "difficulty": "medium",
    "question": "「潜龙勿用」出自哪一卦的哪一爻？",
    "options": [
      "乾卦初九",
      "乾卦九二",
      "坤卦初六",
      "屯卦初九"
    ],
    "correctAnswer": "乾卦初九",
    "explanation": "「潜龙勿用」是乾卦初九的爻辞，意为时机未到，应韬光养晦。"
  },
  {
    "id": 5,
    "category": "历史知识",
    "difficulty": "hard",
    "question": "以下哪位不是著名的易学家？",
    "options": [
      "孔子",
      "王弼",
      "程颐",
      "韩愈"
    ],
    "correctAnswer": "韩愈",
    "explanation": "韩愈是唐代文学家，虽对儒学有研究，但不是专门的易学家。孔子作《易传》，王弼、程颐都是著名易学家。"
  },
  {
    "id": 6,
    "category": "八卦属性",
    "difficulty": "medium",
    "question": "震卦在八卦中的方位是？",
    "options": [
      "东",
      "西",
      "南",
      "北"
    ],
    "correctAnswer": "东",
    "explanation": "震卦象征雷，在八卦方位中属东方，代表春天和清晨。"
  },
  {
    "id": 7,
    "category": "卦象识别",
    "difficulty": "easy",
    "question": "阳爻的符号是？",
    "options": [
      "⚊（实线）",
      "⚋（断线）",
      "两者都是",
      "都不是"
    ],
    "correctAnswer": "⚊（实线）",
    "explanation": "阳爻用一条实线表示，阴爻用中间断开的两条短线表示。"
  },
  {
    "id": 8,
    "category": "卦辞理解",
    "difficulty": "hard",
    "question": "「元亨利贞」被称为乾卦四德，其中「利」的含义是？",
    "options": [
      "和谐适宜",
      "利益好处",
      "锋利",
      "顺利"
    ],
    "correctAnswer": "和谐适宜",
    "explanation": "在易经中，「利」指的是和谐、适宜、合乎义理，而非现代意义的利益。"
  },
  {
    "id": 9,
    "category": "基础知识",
    "difficulty": "easy",
    "question": "易经共有多少卦？",
    "options": [
      "8卦",
      "64卦",
      "128卦",
      "256卦"
    ],
    "correctAnswer": "64卦",
    "explanation": "易经由八卦两两组合形成六十四卦，每卦六爻。"
  },
  {
    "id": 10,
    "category": "历史知识",
    "difficulty": "medium",
    "question": "《易传》又被称为？",
    "options": [
      "十翼",
      "五经",
      "四书",
      "三传"
    ],
    "correctAnswer": "十翼",
    "explanation": "《易传》又称「十翼」，传为孔子所作，包括彖传、象传、系辞等十篇。"
  }
]
```

### 题目分类说明

**类别（category）：**
- 基础知识：易经基本概念
- 卦象识别：辨认卦象和爻位
- 卦辞理解：理解卦辞爻辞含义
- 八卦属性：八卦的属性和特征
- 历史知识：易经发展史和易学家

**难度（difficulty）：**
- easy：简单题，基础概念
- medium：中等题，需要理解
- hard：困难题，需要深入掌握

---

## 数据整理工具

### Python脚本：JSON格式验证

```python
import json

def validate_hexagrams(file_path):
    """验证六十四卦数据格式"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 检查数量
        if len(data) != 64:
            print(f"❌ 卦象数量错误：应为64个，实际{len(data)}个")
            return False
        
        # 检查每个卦的字段
        required_fields = ['id', 'name', 'chineseName', 'upperTrigram', 
                          'lowerTrigram', 'binary', 'symbol', 
                          'description', 'interpretation', 'lines']
        
        for hexagram in data:
            for field in required_fields:
                if field not in hexagram:
                    print(f"❌ 卦{hexagram.get('id', '?')}缺少字段：{field}")
                    return False
            
            # 检查爻数量
            if len(hexagram['lines']) != 6:
                print(f"❌ 卦{hexagram['id']}的爻数量错误：应为6个")
                return False
            
            # 检查二进制长度
            if len(hexagram['binary']) != 6:
                print(f"❌ 卦{hexagram['id']}的二进制长度错误")
                return False
        
        print("✅ 数据格式验证通过！")
        return True
    
    except json.JSONDecodeError as e:
        print(f"❌ JSON格式错误：{e}")
        return False
    except FileNotFoundError:
        print(f"❌ 文件不存在：{file_path}")
        return False

# 使用示例
validate_hexagrams('hexagrams.json')
```

### Excel转JSON工具

如果你在Excel中整理数据，可以使用此脚本转换：

```python
import pandas as pd
import json

def excel_to_json(excel_file, output_file):
    """将Excel数据转换为JSON格式"""
    # 读取Excel
    df = pd.read_excel(excel_file)
    
    hexagrams = []
    
    for _, row in df.iterrows():
        hexagram = {
            "id": int(row['id']),
            "name": row['name'],
            "chineseName": row['chineseName'],
            "upperTrigram": row['upperTrigram'],
            "lowerTrigram": row['lowerTrigram'],
            "binary": row['binary'],
            "symbol": row['symbol'],
            "description": row['description'],
            "interpretation": row['interpretation'],
            "lines": []
        }
        
        # 处理六爻数据（假设在不同列）
        for i in range(1, 7):
            line = {
                "position": i,
                "text": row[f'line{i}_text'],
                "interpretation": row[f'line{i}_interpretation']
            }
            hexagram['lines'].append(line)
        
        hexagrams.append(hexagram)
    
    # 保存为JSON
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(hexagrams, f, ensure_ascii=False, indent=2)
    
    print(f"✅ 成功转换：{output_file}")

# 使用示例
# excel_to_json('hexagrams.xlsx', 'hexagrams.json')
```

---

## 数据来源建议

### 推荐来源
1. **维基文库**
   - 网址：https://zh.wikisource.org/wiki/周易
   - 优点：公版内容，可自由使用
   - 内容：完整的周易原文

2. **国学网**
   - 网址：http://www.guoxue.com/
   - 优点：有注解和白话翻译
   - 内容：丰富的易经资料

3. **书籍扫描**
   - 公版书籍（出版70年以上）
   - 经典注本：如《周易本义》、《周易正义》

### 注意事项
- ⚠️ 确保内容来源合法，尊重版权
- ⚠️ 白话释义需自行编写或使用公版内容
- ⚠️ 避免直接复制现代学者的原创解读
- ⚠️ 保持内容学术性，避免封建迷信表述

---

## 数据检查清单

### 提交前检查

**六十四卦数据：**
- [ ] 卦序1-64完整无遗漏
- [ ] 每个卦都有6个爻
- [ ] 二进制表示正确（6位）
- [ ] 上下卦对应正确
- [ ] 无错别字
- [ ] 白话释义通俗易懂
- [ ] 内容符合社会主义核心价值观

**八卦数据：**
- [ ] 八个卦完整
- [ ] 方位、五行等属性正确
- [ ] 二进制表示正确（3位）
- [ ] 描述清晰准确

**题库数据：**
- [ ] 至少100道题目
- [ ] 涵盖各个难度级别
- [ ] 答案准确无误
- [ ] 解析清晰易懂

---

## 联系与支持

如果在数据整理过程中遇到问题，可以：
1. 查看README.md的资源链接部分
2. 参考技术文档中的数据结构说明
3. 使用提供的验证工具检查格式

**数据整理是项目的基础，请认真对待！** 📚

