import sequtils
import unicode


proc levenshteinDistance(str1, str2: string | seq[Rune]): int =
  var distance: seq[seq[int]] =
    newSeqWith( str1.len + 1
              , newSeq[int](str2.len + 1)
              )
  for i in 0..str1.len:
    distance[i][0] = i
  for j in 1..str2.len:
    distance[0][j] = j
  for i in 1..str1.len:
    for j in 1..str2.len:
      let cost =
        if str1[i - 1] == str2[j - 1]: 0
        else: 1
      distance[i][j] =
        min( [ distance[i - 1][j] + 1
             , distance[i][j - 1] + 1
             , distance[i - 1][j - 1] + cost
             ]
           )
  return distance[str1.len][str2.len]


proc showLD(str1, str2: string | seq[Rune]) =
  echo "Levenshtein Distance between ", str1, " and ", str2,
       " is ", levenshteinDistance(str1, str2)
  echo "(Weight: Insertion = 1, Deletion = 1, Substitution = 1)"


proc main() =
  # ASCII 文字列同士の比較
  const
    str1: string = "santa"
    str2: string = "satan"
  showLD(str1, str2)

  # Unicode 文字列同士の比較
  const
    str3: string = "ニーモニック"
    str4: string = "デモニック"
  showLD(str3.toRunes, str4.toRunes)


if isMainModule:
  main()
