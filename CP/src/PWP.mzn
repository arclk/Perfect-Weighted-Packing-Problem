include "globals.mzn";

int: w;
int: h;
int: n;
set of int: PACK = 1..n;
array[PACK] of int: p_width;
array[PACK] of int: p_height;
%array[PACK] of var 0..h: count;

array[PACK] of var int: x;
array[PACK] of var int: y;

% Domain constraints
constraint forall(i in PACK)(x[i] >= 0);
constraint forall(i in PACK)(y[i] >= 0);
constraint forall(i in PACK)(x[i] <= w - p_width[i]);
constraint forall(i in PACK)(y[i] <= h - p_height[i]);

% Global constraint
% constraint cumulative(x, p_width, p_height, h);
% constraint cumulative(y, p_height, p_width, w);

constraint diffn(x, y, p_width, p_height);


constraint forall(i, j in PACK where (i > j /\ p_height[i]+p_height[j] > h))(x[j] >= x[i]+p_width[i]);
constraint forall(i, j in PACK where (i > j /\ p_width[i]+p_width[j] > w))(y[j] >= y[i]+p_height[i]);

% Implied constraints
constraint forall(i in 0..h)(sum(j in PACK where (y[j] <= i /\ y[j]+p_height[j] > i))(p_width[j]) <= w); 
constraint forall(i in 0..w)(sum(j in PACK where (x[j] <= i /\ x[j]+p_width[j] > i))(p_height[j]) <= h); 



% solve satisfy;

% ann: search_ann;
% search_ann = int_search(q, input_order, indomain_min);
% search_ann = int_search(x, first_fail, indomain_min);
% %search_ann = int_search(q, dom_w_deg, indomain_min);
% %search_ann = int_search(q, input_order, indomain_random);
% search_ann = int_search(x, dom_w_deg, indomain_random);
% search_ann = seq_search([int_search(x, dom_w_deg, indomain_random), int_search(y, dom_w_deg, indomain_random)]);

% solve
%  ::search_ann
%  ::restart_luby(250)
% satisfy; 
% solve :: search_ann satisfy;
solve :: seq_search([
             int_search(x, dom_w_deg, indomain_min),
             int_search(y, dom_w_deg, indomain_min)])
      satisfy;

%output [ "x = \(x)\n"];

% w = 8;
% h = 8;
% n = 4;
% p_width = [3, 3, 5, 5];
% p_height = [3, 5, 3, 5];

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

w = 29;
h = 29;
n = 24;
p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5];
p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 18, 20, 3, 4, 5, 6, 7, 9, 15, 18, 20, 4, 8, 17];



