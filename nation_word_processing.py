import pandas as pd
import numpy as np
import tensorflow as tf
import matplotilb as plt


def birth_calculator(val1 ,val2):
  birth = round(val1/365, 0)
  employed_time = round(val2/365, 0)
  return birth, employed_time
  # i'll just analyze employed data with this function at same time.


def title_save(col):
  for i in col:
    title_base.append(i)
  title_base.pop(0)
  return title_base


title_base = []

# load excel file
df = pd.read_csv('/content/drive/MyDrive/Colab Notebooks/train.csv')

headers = title_save(df.columns)

nonDup_data = df.drop_duplicates(headers, keep = 'first')
eachAge,eachHire = birth_calculator(abs(nonDup_data['DAYS_BIRTH']), nonDup_data['DAYS_EMPLOYED'])

ageDb = []
hireDb = []

for i,j in zip(eachAge,eachHire):
  ageDb.append(i)
  hireDb.append(j)
nonDup_data['DAYS_BIRTH'] = ageDb
nonDup_data['DAYS_EMPLOYED'] = hireDb

nonDup_data

# On this code, I intend to remove some perfectly duplicated values from the table
# And then, analyze the number of rest of them with changing birth and emplyed values to the normal form
# that we get used to.

credits = nonDup_data['credit'].value_counts(ascending = True)

x = [0.0,1.0, 2.0]
y = []

for i in credits:
  y.append(i)

bar = plt.bar(x,y, color = ['r', 'g', 'b'])
plt.xticks(x, x)
plt.title('CREDIT')
plt.xlabel('credit score')
plt.ylabel('bunch of people to have this score')

for i in bar:
  height = i.get_height()
  plt.text(i.get_x() + i.get_width()/2.0, height, '%.1f' % height, ha='center', va='bottom', size = 8)

plt.show()


db = nonDup_data['occyp_type'].fillna('No').value_counts(ascending = True)


# tesorflow model

model = tf.keras.models.Squential([
    tf.keras.layers.Dense(),
    tf.keras.layers.Dense(),
    tf.keras.layers.Dense()
    # 각각이 히든 레이어가 된다고 보면 된다.
    # parenthases 안에 값은 히든 레이어의 갯수를 의미하고 마지막의 레이어는 하나로 고정해야 할 것이다.
    # 왜냐하면 우리는 정확도를 소수점으로 표현 할 것이디 때문이다.
])

model.compile(optimizer = 'adam', loss = 'binary_crossentropy', metrics = ['accuracy'])
# optimizer는 각각의 튀는 값들을 보정해주는 것이고, 내가 원하는 값이 0과 1사이의 값이라고 가정하면ㅊ binary_crossentropy를 사용한다.
# 마지막의 metrics는 내가 원하는 결과의 이름을 정해준 것이다.

model.fit()
# train set, solution, epochs : 학습의 횟수

predictions = model.predict([])



















