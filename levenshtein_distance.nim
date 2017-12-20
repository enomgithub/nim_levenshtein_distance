proc levenshteinDistance(str1: string, str2: string): int =
  const lenMax: int = 100
  var d: array[lenMax, array[lenMax, int]]
  for i in 0..str1.len:
    for j in 0..str2.len:
      d[i][j] =
        if j == 0: i
        elif i == 0: j
        else: 0
  for i in 1..str1.len:
    for j in 1..str2.len:
      let cost =
        if str1[i] == str2[j]: 0
        else: 1
      d[i][j] = min([
        d[i - 1][j] + 1,
        d[i][j - 1] + 1,
        d[i - 1][j - 1] + cost
      ])
  return d[str1.len][str2.len]


proc main() =
  const str1: string = "santa"
  const str2: string = "satan"
  echo "Levenshtein Distance between ", str1, " and ", str2,
       " is ", levenshteinDistance(str1, str2)
  echo "(Weight: Insertion = 1, Deletion = 1, Substitution = 1)"


if isMainModule:
  main()
