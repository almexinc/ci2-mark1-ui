# 目次

- [目次](#目次)
- [QMLのコーディング規約](#qmlのコーディング規約)
- [コーディング規約](#コーディング規約)
  - [Google C++スタイルガイドから外れる規約](#google-cスタイルガイドから外れる規約)
    - [名前空間](#名前空間)
    - [Google特有のマジック](#google特有のマジック)
    - [ファイル名](#ファイル名)
    - [変数名](#変数名)
    - [定数名](#定数名)
    - [関数名](#関数名)
    - [列挙型の名前](#列挙型の名前)
    - [コードのフォーマット](#コードのフォーマット)
  - [その他](#その他)
    - [一部のコメントはDoxygen形式にすると良い](#一部のコメントはdoxygen形式にすると良い)
    - [関数コメントはソースとヘッダの両方に書く](#関数コメントはソースとヘッダの両方に書く)
    - [メンバ変数・関数にアクセスする場合は this を記載してアクセスする](#メンバ変数関数にアクセスする場合は-this-を記載してアクセスする)
- [ライセンス](#ライセンス)
  - [yaml-cpp](#yaml-cpp)

# QMLのコーディング規約

通常は外部（別会社や別部署）で作成頂いたQMLファイルに合うように対応してください。  

ゼロベースから作る場合などは、Qt公式に従います。  
https://doc.qt.io/qt-6/qml-codingconventions.html  

Qt公式のコーディング規約からの例外は、id名は`_`を先頭につけます。  

# コーディング規約

C++のバージョンとしてはC++20を使用します。  

MSVCでビルドされるWindowsアプリですが、今後、Android向けビルドが想定されているため、Windows向けだとわかっているコードはif/defで切る必要があります。  

以下をベースとしています。  
誤解などあると思いますが、可能な限りこちらに従うようにしてください。  

*Google C++ スタイルガイド 日本語全訳*  
https://ttsuki.github.io/styleguide/cppguide.ja.html

ただし、ベースガイドに不定期に更新があるので、どこかでずれるかもしれません。  
例えば、ポインタを引き数に渡す条件は2020年？　以降に大きく変更されました。  

直接HTMLファイル表示となりますが、[このコミットの日本語訳を前提としています。](https://github.com/ttsuki/styleguide/blob/73a07ef22c426ebf3da6dbbe977d768e97fd24e4/cppguide.ja.html)  

## Google C++スタイルガイドから外れる規約
### 名前空間

https://ttsuki.github.io/styleguide/cppguide.ja.html#Namespaces

無くて良いです。  
理由としては名前空間が必須になるほど大規模なコードにならないためとなります。  
必要に応じて設定してください。  

### Google特有のマジック

https://ttsuki.github.io/styleguide/cppguide.ja.html#Google-Specific_Magic

こちらは参照しません。  

### ファイル名

https://ttsuki.github.io/styleguide/cppguide.ja.html#File_Names

ファイル名にハイフンを使うより、アンダーバーを検討してください。  
例えば、QtのC++ファイル名はハイフンを許容していないためとなります。  

### 変数名

https://ttsuki.github.io/styleguide/cppguide.ja.html#Variable_Names

スネークケースを使わないようにしてください。  
小文字から始めてください。  

```cpp
int localId;
```

クラスのメンバ変数は「_」から始めてください。  

```cpp
class A {
private:
    int _localId;
}

struct {
    int _localId;
}
```

「クラスのデータメンバ」に記載されている末尾のアンダースコアはつけません。  

### 定数名

https://ttsuki.github.io/styleguide/cppguide.ja.html#Constant_Names

大文字のスネークケースを基本としてください。  

```cpp
#define LOCAL_ID (1)
const int LOCAL_ID = 1;
```

### 関数名

https://ttsuki.github.io/styleguide/cppguide.ja.html#Function_Names

小文字から始めてください。  

### 列挙型の名前

https://ttsuki.github.io/styleguide/cppguide.ja.html#Enumerator_Names

本ドキュメントの定数名にしたがってください。  
[定数名](#定数名)  

### コードのフォーマット

https://ttsuki.github.io/styleguide/cppguide.ja.html#Formatting

clang-fomatによって整形しています。  
フォルダに配置された `.clang-format` を使って整形してください。  

## その他
### 一部のコメントはDoxygen形式にすると良い

クラス名、関数名などは特にそうなります。  

```cpp
/**
 * @brief コンストラクタ
 * @param parent 親オブジェクト
 */
AutoCancelController::AutoCancelController( QObject *parent )
```

### 関数コメントはソースとヘッダの両方に書く

二度手間になりますが、コード作成よりコードを閲覧する時間の方が長いという一般規則に従った場合、ヘッダとソースの両方を見聞きする必要が無くなった方が良いと判断しました。  

### メンバ変数・関数にアクセスする場合は this を記載してアクセスする

```cpp
class A {
:
:
private:
    void getLocalId();
    int _localId;

};
:
:
void A::test() {
    this->_localId;
    this->getLocalId();
}
```

# ライセンス

サードパーティのライセンス表記  

## yaml-cpp

MITライセンス条文リンク  
https://github.com/jbeder/yaml-cpp/blob/master/LICENSE  

