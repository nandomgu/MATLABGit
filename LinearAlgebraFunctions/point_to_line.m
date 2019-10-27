function d = point_to_line(pt, v1, v2)
    %%this function calculates the shortest distance
    %%in multidimensional space from point pt to the line going from v1 to
    %%v2.
      a = v1 - v2;
      b = pt - v2;
      d = norm(cross(a,b)) / norm(a);