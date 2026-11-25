# LiNEA40 keymap の判定ルール

40% + 1u トラックボール + 日本語入力向けの、クリック／句読点／スクロールの切り替えメモ。アルファベットの物理位置は動かさない。

## レイヤー

0–8 が Mac、10–17 が Windows。Windows の下一桁は同じ役割の Mac 層と対応する（例: MARK 3 ↔ WIN_MARK 13）。9 / 11 / 14 は番号合わせの空き。REMOTE（Jump Desktop）は Mac 側だけ。

| 番号 | 名前 | 入り方 |
|---|---|---|
| 0 | デフォルト（Mac、直接接続） | 起動時。再起動でもここ。英数は LANG2、かなは LANG1 |
| 1 | REMOTE | Mac の Jump Desktop。プロファイル1で足す。英数は右Ctrl+Shift+;、かなは右Ctrl+Shift+J |
| 2 | MOUSE | ボールを動かすと自動。クリック以外のキー、または最後の移動から 1.5s で解除 |
| 3 | MARK（記号） | Mac。右 Enter ホールド |
| 4 | FUNCTION（移動・IME） | Mac。左 Space ホールド。REMOTE（Jump Desktop）のとき |
| 5 | FUNCTION_DIRECT | Mac。左 Space ホールド。直接接続。英数は LANG2、かなは LANG1 |
| 6 | SCROLL（ホイール） | Mac。J ホールド |
| 7 | META（Bluetooth） | Mac。FUNCTION の P を押している間 |
| 8 | SCROLL_REMOTE（ホイール） | Mac Jump Desktop。J ホールド。向きは逆、速度は半分 |
| 9 | （空き） | Windows を 10 から始めるための番兵 |
| 10 | WINDOWS（=0） | Windows 基本。META / WIN_META の X。Cmd→Ctrl、Opt→Win、Ctrl→Alt |
| 11 | （空き =1） | REMOTE 相当。Jump Desktop は Windows に無い |
| 12 | WIN_MOUSE（=2） | WINDOWS かつ MOUSE のとき自動（ボールは常に MOUSE を足すための橋渡し） |
| 13 | WIN_MARK（=3） | Windows。右 Enter ホールド |
| 14 | （空き =4） | FUNCTION 相当。Jump Desktop 用は Windows に無い |
| 15 | WIN_FUNCTION_DIRECT（=5） | Windows。左 Space ホールド。英数は LANG2、かなは LANG1 |
| 16 | WIN_SCROLL（=6） | Windows。J ホールド |
| 17 | WIN_META（=7） | Windows。WIN_FUNCTION_DIRECT の P を押している間 |

```
Q  W  E  R  T                      Y  U  I  O  P
A  S  D  F  G                      H  J* K  L  -
Z  X  C  V  B                      N  M  MB1† MB2† BS
Cmd Opt Ctrl TAB 英数[SFT]  SPC[FN]  ENT[MARK]  かな[SFT]  Ctrl Opt Cmd
```

Windows 基本レイヤーでは、親指の修飾だけが次になる。文字位置は同じ。

```
Ctrl Win Alt TAB 英数[SFT]  SPC[FN]  ENT[MARK]  かな[SFT]  Alt Win Ctrl
```

`*` tap は文字、hold は SCROLL（Windows では WIN_SCROLL）。`†` 文脈でクリックか句読点。`[SFT]` は hold が Shift。tap は、Mac 直接接続と Windows では英数（LANG2）とかな（LANG1）。Mac の Jump Desktop（プロファイル1）では英数（右Ctrl+Shift+;）とかな（右Ctrl+Shift+J）。

Mac では、左下の Command / Option / Control と、右下の Control / Option / Command は専用キー。MARK は右 Enter ホールド（`&ak_lt` なので入場時に F21）。

## Windows

Space を押したまま P で META（または WIN_META）に入り、離す前に Z か X を押す。

- **Z** は Mac。起動時と再起動後もこちら
- **X** は Windows を基本レイヤーにする。10–17 は Mac 側の写し（下一桁対応）で、hold 先も Windows 側だけを指す

| Mac のキー | Windows で出るキー |
|---|---|
| Command | Ctrl |
| Option | Win |
| Control | Alt |

左右とも同じ。WIN_MARK の `{` `}` `|` `?` のホールドもこの対応に従う。英数（LANG2）とかな（LANG1）はそのまま。REMOTE は Mac の Jump Desktop 専用なので、Windows 系統には無い。

右 Cmd を押したままの `,` `.` は、同じ物理キー（Windows では右 Ctrl）で `,` `.` になる。左 Shift を押したままは、これまで通りクリック。

X や Z で OS を切り替えると REMOTE は外れる。Windows のままプロファイル 1 を選んでも接続先が変わるだけで、Jump Desktop 用の英数/かなにはならない。プロファイル 0 と 1 を Windows 中に選んでも、Windows は外れない。

ボールはハード側の都合で常に MOUSE（2）を足す。Windows 基本のときだけ `WINDOWS + MOUSE → WIN_MOUSE` で Windows 側の写しに載せ替える。それ以外の Windows 層は、基本レイヤーの hold から直接入る。

Win キーは単体で離すとスタートメニューが開く。Alt キーは単体で離すとメニューバーにフォーカスすることがある。

## MARK（記号）

右 Enter ホールドで入る。上2段は数字とそのシフト側。`/` と `?` はここだけにある。Windows では WIN_MARK。

```
1   2   3     4    5                   6   7  8     9   0
!   @   #     $    %                   ^   &  *     (   )
[   ]   =     +    ;                   `   "  '     \   /
{‡  }‡  Ctrl  TAB  :‡  SPC  ENT[MARK]  ~‡     Ctrl  |‡  ?‡
```

`‡` は tap が記号、hold が基本レイヤーと同じモディファイア。Mac は左から Command、Option、左 Shift、右 Shift、Option、Command。Windows は Ctrl、Win、左 Shift、右 Shift、Win、Ctrl。Ctrl の位置（透過）は、Mac では Control、Windows では Alt。

- モディファイアを押したまま他のキーを押した時点でモディファイアに確定する（`hold-preferred`）。離す順は問わない
- 他のキーより先にその親指だけを離すと記号。200ms 以上押したままにしても記号は出ず、モディファイアだけになる
- 記号の直後に次のキーへロールすると、親指を離す前に次が入った時点でモディファイアになる。`?n` のように続けるときは、記号の親指を先に離す
- Ctrl と Tab は透過で、基本レイヤーの専用キーのまま
- Space は素の Space。MARK 中に FUNCTION へは入らない
- Enter は透過のまま（このキーのホールドが MARK）

FUNCTION（左 Space ホールド）の Enter 親指は素の Enter。Space を押したまま Enter を押しても MARK は乗らない。FUNCTION の P は押している間 META（Windows では WIN_META）で、P は出ない。

## META（Bluetooth）

Space を押したまま P をホールドして入る。スプリットの初期設定でホスト用プロファイルは 5 つ（0–4）。Windows では WIN_META。

```
0    1    2    3    4                 前   次
切0  切1  切2  切3  切4
Mac  Win                                  解除  全解除
```

- 上段左（Q–T）はプロファイル選択。`0` は直接接続（英数 LANG2、かな LANG1）。`1` は Mac では Jump Desktop（右Ctrl+Shift+; / 右Ctrl+Shift+J）で、Windows では接続先だけで REMOTE は乗らない。`2` `3` `4` は接続先だけで、英数・かなの形式は変えない
- 下段左の Z / X は基本レイヤー。Z が Mac、X が Windows。切り替えると REMOTE は外れる
- 起動直後は直接接続。リモート接続で使うときは `1` を一度押す。`前` / `次` でも形式は変わらない
- 中段左（A–G）は、その番号の非アクティブ接続を切る `BT_DISC`
- 上段右の Y / U は前 / 次のプロファイル
- `.` は現在のプロファイルのペアリング解除（`BT_CLR`）
- 右端の Backspace は全プロファイル解除（`BT_CLR_ALL`）

## クリックと句読点（いちばん複雑）

`ak_mb1` / `ak_mb2` はデフォルトが MB1 / MB2。読点は文の続きでしか打たない、という前提で、**何もしていないときはクリック**にする。

### 優先順位（上ほど強い）

1. **左 Shift 押しながら** → クリック（Shift+ドラッグ用。右手ボールと両立）
2. **右 Shift、または右 Cmd 押しながら** → `,` / `.`（右 Shift は `<>`）。Windows では右 Cmd の位置が右 Ctrl
3. **ボール操作中〜その後（MOUSE / WIN_MOUSE）** → クリック  
   ボールを動かすと MOUSE が乗る。Windows 基本のときは WIN_MOUSE に載せ替わる。クリックキー以外を押すか、ボールを止めて 1.5s で外れる。直前の句読点クールタイムは打ち切る。
4. **直前 4 秒が文章操作（MOUSE / WIN_MOUSE でない）** → 句読点（`,` / `.`）
5. **それ以外（アイドル、Ctrl+S など）** → クリック

### 「文章操作」とみなすもの

- 修飾なしの A–Z、および左右 Shift 付きの A–Z（`OK` など）
- 数字、Space、Enter、BS、一部記号
- 右Ctrl+Shift+; / 右Ctrl+Shift+J（Mac の Jump Desktop、プロファイル1）、および LANG1 / LANG2（Mac 直接接続、および Windows）
- 矢印、Page Up/Down、Home、End
- MARK / WIN_MARK または FUNCTION / FUNCTION_DIRECT / WIN_FUNCTION_DIRECT に **入ったこと**（内部だけ F21 を出し、ホストには送らない）
- Ctrl/Cmd + C / V / X（コピー・ペースト・カット）

Ctrl / GUI / Alt 付きのその他の文字（Ctrl+S など）は文章操作に入れない。

### 時間

| | 長さ | 意味 |
|---|---|---|
| 句読点クールタイム | 4s | 最後の文章キーから。ボール操作で打ち切り |
| MOUSE レイヤー | 1.5s | 最後のボール移動から。クリック（位置 27/28）以外のキーでも解除 |

SCROLL（J hold）ではダミーキーを出さない。スクロール中はクリックしたいため。

## J ホールド（SCROLL）

1u ボールは親指ホールドと同時操作しにくいので、ボール隣の J で SCROLL に入る。M は通常の文字キー。Windows では WIN_SCROLL。

- 次が **文字・`-`・Backspace・`,`・`.`** → tap（`jk` と同じく、J を離しきる前に押しても `j,` / `j.`）。`like` のようなロールで文字が消えないようにする
- 次が **親指**、または 200ms 以上の単独ホールド → SCROLL（ボールがホイール）
- J を押した瞬間から SCROLL に入る（`hold-while-undecided`）。タップに決まると層を外してから文字を出す
- 打鍵直後 125ms 以内の J は即 tap
- 同じキーの連打（175ms 以内）は tap のまま（`jj` など）
- SCROLL が 200ms で確定したあとの句読点キーは、これまで通りクリック
- プロファイル1（Jump Desktop）の J ホールドは SCROLL_REMOTE。縦方向は直接接続と逆で、ボール移動に対するスクロール量は半分（1/60。直接接続は 1/30）

英字（A–Z）と `-`、Backspace、`,` `.` の位置は `hold-trigger-key-positions` に入れない。入れると、そのキーへ続く J がタップにならず、`j,` や単語のロールが切れる。

SCROLL 上で差し替えるのは次だけ。MB3 は右 Enter、MB4 は右 Shift、MB5 は右 Cmd の位置。`-` と右下端の Backspace は透過なので、文字と削除のまま出る。右 Shift と右 Cmd の位置はこのレイヤーだけマウスボタンになる。`ak_mb1` / `ak_mb2` 位置は `&trans` なので、通常クリックは下のレイヤーに抜ける。

## 実装上の制約

- adaptive-key の `trigger-keys` は **1 条件あたり 32 個まで**。左右 Shift 付き文字は `after_ls` / `after_rs` に分割している。足すときはこの上限を超えないこと。
- レイヤー入場のマーカは F21（`AK_LAYER_MARK`）。`dead-keys` でホストには出さない。Mac の Jump Desktop（プロファイル1）の英数は右Ctrl+Shift+;、かなは右Ctrl+Shift+J。Mac 直接接続と Windows は LANG2 と LANG1。F15 は macOS で使われうるので使わない。
- keymap の層を挿入すると番号がずれる。`#define` と、右ボールの `snipe-layers`（MARK / WIN_MARK）`scroll-layers`（SCROLL / WIN_SCROLL / SCROLL_REMOTE）を同じ番号に揃える。J の `hold-trigger-key-positions` はキー位置なので、層番号とは別。
- Shift を押したまま句読点キーを叩くと `,` が `<` になる。大文字のあと Shift は離してから。
- Windows 側を直すときは、下一桁が同じ Mac 側も同じ内容か確認する（10↔0、12↔2、13↔3、15↔5、16↔6、17↔7）。
