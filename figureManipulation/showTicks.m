function showTicks(fig)

w=whichSelected(fig);

a=getAllAxes(fig);
a=a(w);

 for j=1:numel(a)
     
     nr= get(a(j), 'XAxis');
     set(nr, 'Visible', 'on')
     
     nr= get(a(j), 'YAxis');
     for b=1:numel(nr)
         
         set(nr(b), 'Visible', 'on');
     end
 end