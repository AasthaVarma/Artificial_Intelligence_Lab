#include<bits/stdc++.h>
#define n 5
using namespace std;

bool compare_fun(const pair<string, int> p1,const pair<string, int> p2)
{
	return p1.second > p2.second;
}
	
int main()
{
	int a[n][n] = {{INT_MAX, 10, 8, 9, 7},
				   {10, INT_MAX, 10, 5, 6},
				   {8, 10, INT_MAX, 8, 9},
				   {9, 5, 8, INT_MAX, 6},
				   {7, 6, 9, 6, INT_MAX}
				   };
				   
	int d[n] = {0, 1, 2, 3, 4};
	vector<pair<string, int> > vec;
	int count = 0;
	do{
		count++;
		int cost = 0;
		string str = "";
		str.push_back(d[0]+'0');
		int i;
		for(i=1; i<n; i++)
		{
			cost += a[d[i-1]][d[i]];
			str.push_back(d[i]+'0');	
		}
		cost += a[d[i-1]][d[0]];
		str.push_back(d[0]+'0');
		
		vec.push_back(make_pair(str, cost));
	}while(next_permutation(d, d+n));
	
	pair<string, int> q =  *max_element(vec.begin(), vec.end(), compare_fun);
	//cout << vec.size() << " " << count << "\n";
	cout << q.second << " " << q.first;
	return 0;
}
