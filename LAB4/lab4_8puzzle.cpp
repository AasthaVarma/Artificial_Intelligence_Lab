//8 puzzle using A* algorithm.
#include<bits/stdc++.h>
#include<functional>
using namespace std;

typedef vector<vector<int>> vvi;
typedef pair<vector<vector<int>>, int> state;

vvi goal(3, vector<int>(3));
map<int, pair<int, int>> g_xy;
map<vvi, bool> visited;
map<vvi, vvi> parent;
int dx[] = {-1, 1, 0, 0};
int dy[] = {0, 0, -1, 1};
int min_count = 0;

void print_path(vvi s)
{
	if(parent.count(s))
	{
		print_path(parent[s]);
		min_count++;
	}
		
	for(int i=0; i<3; i++)
	{
		for(int j=0; j<3; j++)
			cout << s[i][j] << " ";
		cout << "\n";
	}
	cout << "\n";
	return;
}


int manhattan(vvi a, int moves)
{
	int cnt=moves;
	for(int i=0; i<3; i++)
	{
		for(int j=0; j<3; j++)
		{
			cnt += abs(i-g_xy[a[i][j]].first)+
					abs(j-g_xy[a[i][j]].second);
		}
	}
	return cnt;
}

bool isGoal(vvi a)
{
	for(int i=0; i<3; i++)
	{
		for(int j=0; j<3; j++)
		{
			if(a[i][j] != goal[i][j])
				return false;
		}
	}
	return true;
}

bool isSafe(int i, int j)
{
	return (0<=i && i<=2 && 0<=j && j<=2);
}

struct cmp
{
	bool operator()(state &a, state &b)
	{
		int l = manhattan(a.first, a.second);
		int r = manhattan(b.first, b.second);
		
		return l<r;
	}
};

vector<vvi> neighbours(vvi a)
{
	pair<int, int> pos;
	for(int i=0; i<3; i++)
	{
		for(int j=0; j<3; j++)
		{
			if(a[i][j]==0)
			{
				pos.first = i;
				pos.second = j;
				break;
			}
		}
	}
	
	vector<vvi> ans;
	for(int k=0; k<4; k++)
	{
		int cx = pos.first;
		int cy = pos.second;
		vvi n = a;
		if(isSafe(cx+dx[k], cy+dy[k]))
		{
			swap(n[cx+dx[k]][cy+dy[k]], n[cx][cy]);
			ans.push_back(n);
		}
	}
	return ans;
}

void solve(vector<vector<int>>a ,int moves)
{
	priority_queue<state, vector<state>, cmp> pq;
	pq.push(state(a, moves));
	while(!pq.empty())
	{
		vvi s = pq.top().first;
		pq.pop();
		visited[s] = true;
		
		if(s==goal)
		{
			print_path(s);
			break;
		}
		vector<vvi> ns = neighbours(s);
		vector<vvi>::iterator it;
		for(it=ns.begin(); it!=ns.end(); it++)
		{
			vvi temp = *it;
			if(!visited[temp])
			{
				parent.insert({temp, s});
				pq.push(state(temp, moves+1));
				
			}
		}
	}
	return;
}
void print(vector<vector<int>> a)
{
	for(int i=0; i<3; i++)
	{
		for(int j=0; j<3; j++)
			cout << a[i][j] << " ";
		cout << "\n";
	}
}

int main()
{
	vector<vector<int>> a(3, vector<int>(3));
	for(int i=0; i<3; i++)
		for(int j=0; j<3; j++)
			cin >> a[i][j];
	
	int cnt=1;
	for(int i=0; i<3; i++)
	{
		for(int j=0; j<3; j++)
		{
			goal[i][j] = (cnt++)%9;
			g_xy[goal[i][j]]= {i, j};
		}
	}
	/*
	for(int i=0; i<3; i++)
	{
		for(int j=0; j<3; j++)
		{
			cout << g_xy[goal[i][j]].first << " " << g_xy[goal[i][j]].second <<"\n";
		}
	}		
	*/
	cout << "Solution: \n";
	solve(a, 0);
	
	cout << "Min-count: " << min_count << "\n";
	return 0;
}
