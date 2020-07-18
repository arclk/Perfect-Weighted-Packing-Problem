include "globals.mzn";

int: w;
int: h;
int: n;
set of int: PACK = 1..n;
array[PACK] of int: p_width;
array[PACK] of int: p_height;

% Variables
array[PACK] of var 0..w: x;

% Domain constraints
constraint forall(i in PACK)(x[i] <= w - p_width[i]);

% Global constraint
constraint cumulative(x, p_width, p_height, h);

% Implied constraints
constraint forall(i in 0..w)(sum(j in PACK where (x[j] <= i /\ x[j]+p_width[j] > i))(p_height[j]) <= h); 


solve satisfy;


% ann: search_ann;
% search_ann = int_search(x, first_fail, indomain_min);
% solve :: search_ann satisfy;


% w = 32;
% h = 32;
% n = 27;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4];
% p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18, 22, 23, 24, 25, 27, 3, 4, 5, 6, 7, 10, 11, 18];

% w = 23;
% h = 23;
% n = 19;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 6];
% p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 20, 3, 4, 6, 10, 11, 12, 3];

% w = 29;
% h = 29;
% n = 24;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5];
% p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 18, 20, 3, 4, 5, 6, 7, 9, 15, 18, 20, 4, 8, 17];

% w = 39;
% h = 39;
% n = 29;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 15];
% p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 3, 4, 5, 6, 8, 9, 12, 15, 16, 3, 4, 5, 6, 8, 10, 11, 13, 18, 39];

% w = 37;
% h = 37;
% n = 27;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 12];
% p_height = [3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 17, 18, 21, 3, 4, 5, 6, 10, 22, 24, 3, 4, 6, 10, 14, 37];

% w = 38;
% h = 38;
% n = 19;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 24];
% p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 3, 5, 6, 8, 11, 12, 15, 16, 38];




