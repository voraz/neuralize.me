require 'inline'
module Distance
  
  def initialize args
    super args
    if $use_c
      alias :index_distance       :c_index_distance
      alias :euclidean_distance   :c_euclidean_distance
      alias :closer               :rb_closer
      alias :in_range             :c_in_range
    else
      alias :index_distance       :rb_index_distance
      alias :euclidean_distance   :rb_euclidean_distance
      alias :closer               :rb_closer
      alias :in_range             :rb_in_range
    end
  end
  

  def rb_index_distance(closer, range)
    [ (closer[0]-range[0]).abs, (closer[1]-range[1]).abs ].max
  end
  def rb_euclidean_distance(x, y)
    dist = 0
    x.each_index do |k|
      dist += (x[k]-y[k])**2
    end
    Math.sqrt(dist)
  end
  def rb_closer(x, array)
    closer = [0, 0]
    array.each_index do |i|
      array[i].each_index do |j|
        p = [i, j]
        if array[i][j]==x
          closer = p
          break
        elsif euclidean_distance(x, array[p[0]][p[1]]) < euclidean_distance(x, array[closer[0]][closer[1]])
          closer = p
        end
      end
    end
    closer
  end
  def rb_in_range(x, closer, range)
    index_distance(closer, x)<=range
  end

  inline(:C) do |builder|
    builder.add_compile_flags '-x c++', '-lstdc++'
    builder.include '<ruby.h>'
		builder.include '<algorithm>'
		builder.include '<stdio.h>'
		builder.include '<cmath>'
		builder.include '<iostream>'

    builder.c '
      int c_index_distance(VALUE closer, VALUE range){
          return std::max( abs(RARRAY_PTR(closer)[0]-RARRAY_PTR(range)[0]), abs(RARRAY_PTR(closer)[1]-RARRAY_PTR(range)[1]) );
        }'
        
    builder.c '
        double c_euclidean_distance(VALUE x, VALUE y){
          double dist = 0;
          for( int i=0; i<RARRAY_LEN(x); i++ ){
            dist += pow( (NUM2DBL(RARRAY_PTR(x)[i]) - NUM2DBL(RARRAY_PTR(y)[i])), 2);
          }
          return sqrt(dist);
        }'

    builder.c '
        VALUE c_in_range(VALUE x, VALUE closer, VALUE range){
          return c_index_distance(self, closer, x)<=range;
        }'
=begin            
    builder.c '
        VALUE c_closer(VALUE x, VALUE array)[]{
          int closer[2] = {0, 0};
          for( int i=0; i<RARRAY_LEN(array); i++){
            
            for( int j=0; j<RARRAY_LEN(RARRAY_PTR(array)[i]); j++){
              if( RARRAY_PTR(RARRAY_PTR(array)[i])[j]== RARRAY_PTR(x)){
                closer[0] = i;
                closer[1] = j;  
                printf("s a porra");
              }
              //c_euclidean_distance(self, RARRAY_PTR(x), RARRAY_PTR(RARRAY_PTR(array)[i])[j]);
              /*else if( c_euclidean_distance(self, RARRAY_PTR(x), RARRAY_PTR(RARRAY_PTR(array)[i])[j]) < c_euclidean_distance(self, x, RARRAY_PTR(RARRAY_PTR(array)[closer[0]])[closer[1]]) ){
                closer[0] = i;
                closer[1] = j;
              }*/
            };
          };
          return rb_ary_new3(2, INT2FIX(closer[0]), INT2FIX(closer[1]));
        }'
=end
    
    end


  def self.test
    p1 = [1,1]
    p2 = [ [1,1],[231,2131],[2,1] ]
    p Distance.new.c_closer( p1, p2 )
    p Distance.new.rb_closer( p1, p2 )
  end

end
