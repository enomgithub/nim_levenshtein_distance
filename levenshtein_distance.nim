import sequtils
import unicode


proc levenshteinDistance( str1: string | seq[Rune]
                        , str2: string | seq[Rune]
                        ): int =
  var d: seq[seq[int]] = newSeqWith(str1.len + 1, newSeq[int](str2.len + 1))
  for i in 0..str1.len:
    for j in 0..str2.len:
      d[i][j] =
        if j == 0: i
        elif i == 0: j
        else: 0
  for i in 1..str1.len:
    for j in 1..str2.len:
      let cost =
        if str1[i - 1] == str2[j - 1]: 0
        else: 1
      d[i][j] =
        min( [ d[i - 1][j] + 1
             , d[i][j - 1] + 1
             , d[i - 1][j - 1] + cost
             ]
           )
  return d[str1.len][str2.len]


proc main() =
  # ASCII 文字列同士の比較
  const str1: string = "santa"
  const str2: string = "satan"
  echo "Levenshtein Distance between ", str1, " and ", str2,
       " is ", levenshteinDistance(str1, str2)
  echo "(Weight: Insertion = 1, Deletion = 1, Substitution = 1)"

  # Unicode 文字列同士の比較
  const str3: string = "ニーモニック"
  const str4: string = "デモニック"
  echo "Levenshtein Distance between ", str3, " and ", str4,
       " is ", levenshteinDistance(str3.toRunes, str4.toRunes)
  echo "(Weight: Insertion = 1, Deletion = 1, Substitution = 1)"


if isMainModule:
  main()
