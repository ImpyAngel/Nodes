def hamming(seq1, seq2):
	ans = abs(len(seq1) - len(seq2))
	for i in range(len(seq1)):
		if (seq1[i] != seq2[i]):
		 ans += 1
	return ans

def init(rows, cols, gap_penalty=10):
	arr = [[0.0 for i in range(cols + 1)] for j in range(rows + 1)]
	for i in range(cols + 1):
		arr[0][i] = -i * gap_penalty;
	for i in range(rows + 1):
		arr[i][0] = -i * gap_penalty;
	return arr

def get_new_score(up, left, middle,
				  matched, gap_penalty, match, mismatch):
	return max(middle + (match if matched else mismatch), 
				left - gap_penalty,
				up - gap_penalty)	

def align(top_seq, bottom_seq, gap_penalty=10,match=2, mismatch=-1):
	rows = len(top_seq)
	cols = len(bottom_seq)
	arr = init(rows, cols, gap_penalty)
	ans = 0.0;
	for i in range(1, rows + 1):
	   for j in range(1, cols + 1):
	   	arr[i][j] = get_new_score(arr[i - 1][j], arr[i][j - 1], arr[i - 1][j - 1], (top_seq[i - 1] == bottom_seq[j - 1]), gap_penalty, match, mismatch)
	   	ans = max(ans,arr[i][j])
	return ans

def get_alignment(top_seq, bottom_seq, sm,
                  gap_penalty, match, mismatch):
    aligned1 = AGCT
    aligned2 = AGCT
    return "{}\n{}".format(aligned1, aligned2)

def align(top_seq, bottom_seq, gap_penalty=10,
          match=2, mismatch=-1):
    score = 0
    sm = [[]]
    aligns = get_alignment(top_seq, bottom_seq, sm, gap_penalty, match, mismatch)
    return aligns, score

def main():

	# print(hamming("ASDhh","ADShhg"))
	# print(init(4, 5))
	ans =align(
"CACGGGTGTGTTGACCCC",
"TGCGTAAGTGGATGC",
4, 2, -4
)
	print(ans)
if __name__ == "__main__":
	main()