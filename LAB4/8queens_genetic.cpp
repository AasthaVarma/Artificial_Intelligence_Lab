#include<bits/stdc++.h>
using namespace std;
int n = 5;
int maxFitness = (n*(n-1))/2;
vector<float> probabilities(vector<int> fit)
{
	vector<float> v;
	for(int i=0; i<fit.size(); i++)
		v[i] = (float)(fit[i]/maxFitness);
	return v;
}
string random_pick(vector<string> p, vector<float> fit_prob)
{
	float sum = 0;
	for(int i=0; i<fit_prob.size(); i++)
		sum += fit_prob[i];
	
	float upto = 0;
	for(int i=0; i<p.size(); i++)
	{
		if((upto+fit_prob[i])>= sum)
			return p[i];
		upto += fit_prob[i];
	}
	
}
string mutation(string x)
{
	string n=x;
	int c = rand()%x.length();
	int num = rand()%8+1;
	n[c] = num+'0';
	return n;
}
string single_point_crossover(string x, string y)
{
	string z = "";
	int c = rand() % x.length();
	z += x.substr(0, c);
	z += y.substr(c, y.length()-c+1);
	
	return z;
}

int rowClashes(string s)
{
	set<int> q;
	for(int i=0; i<s.length(); i++)
		q.insert(s[i]);
	return s.length() - q.size();
}
int fitness(string s)
{
	int r=0;
	r += rowClashes(s);
	cout << r << " ";
	int left_diag[2*n+1];
	int right_diag[2*n+1];
	memset(left_diag, 0, sizeof(left_diag));
	memset(right_diag, 0, sizeof(right_diag));
	
	for(int i=0; i<s.length(); i++)
	{
		left_diag[i+s[i]+1] += 1;
		right_diag[n-(i+1+s[i])] += 1;
	}
	int diag_coll = 0;
	for(int i=1; i<=2*n; i++)
	{
		int count = 0;
		if(left_diag[i]>1)
			count += left_diag[i] - 1;
		if(right_diag[i]>1)
			count += right_diag[i] - 1;
		diag_coll += count/(n-abs(i-n+2));
	}
	return maxFitness - (r+ diag_coll);
}
vector<int> fitness_population(vector<string> p)
{
	vector<int> v;
	for(int i=0; i<p.size(); i++)
		v.push_back(fitness(p[i]));
	return v;
}
template <class T>
void print(vector<T> v)
{
	for(int i=0; i<v.size(); i++)
		cout << v[i] << " ";
	cout << "\n";
}

vector<string> random_select_initial(vector<string> v, int pop_num)
{
	vector<string> population;
	for(int i=0; i<pop_num; i++)
	{
		int index = rand()%pop_num+1;
		//cout << index << " " << v[index] << "\n";
		population.push_back(v[index]);
	}
	return population;
}

vector<string> genetic_algo(vector<string> p, vector<int> fit)
{
	int mut_probability = 0.03;
	vector<string> new_population;
	vector<float> fit_prob;
	fit_prob = probabilities(fit);
	
	for(int i=0; i<p.size(); i++)
	{
		string x = random_pick(p, fit_prob);
		string y = random_pick(p, fit_prob);
		
		string child = single_point_crossover(x, y);
		if(rand() < mut_probability)
			child = mutation(child);
		//cout << child << "\n";
		new_population.push_back(child);
		if(fitness(child)==28)
			break;
	}
	return new_population;
}
int main()
{
	srand(time(NULL));
	
	vector<int> v;
	for(int i=1; i<=n; i++)
		v.push_back(i);
	vector<string> pop;
	do{
		string str = "";
		for(int i=0; i<n; i++)	
			str += to_string(v[i]);
		pop.push_back(str);
	//	cout << str << "\n";	
	}while(next_permutation(v.begin(), v.end()));
	//cout << pop.size() <<"\n";
	vector<string> population;
	int population_number = 10;
	population = random_select_initial(pop, population_number);
	
	
	vector<int> fit_vec = fitness_population(population);
	int curr_maxFitness = *max_element(fit_vec.begin(), fit_vec.end());
	int generation = 1;
	while(curr_maxFitness!=maxFitness)
	{
		cout << "Generation: " << generation << "\n";
		population = genetic_algo(population, fit_vec);
		fit_vec = fitness_population(population);
	int curr_maxFitness = *max_element(fit_vec.begin(), fit_vec.end());
		//print(population);
		generation += 1;
	}
	
	fit_vec = fitness_population(population);
	if(curr_maxFitness == maxFitness)
	{
		cout << "Final solution :: ";
		
		for(int i=0; i<fit_vec.size(); i++)
			if(fit_vec[i]==28)
				cout << population[i] << "\n";
	}
	return 0;
}

//test main
/*int main()
{
	srand(time(NULL));
	
	return 0;
}
*/
