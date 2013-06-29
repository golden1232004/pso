function [ ] = train(obj, varargin  )
%
    count = 0;
    max_iterator = obj.max_iterator;
    pop = obj.pop;
    pop_best_fitness = obj.pop_best_fitness;
    pop_best_pos = obj.pop_best_pos;   
    individuals_best_fitness = obj.individuals_best_fitness;     
    individuals_best_pos = obj.individuals_best_pos;
    individuals_pos = obj.individuals_pos;
    speed = obj.individuals_speed;
    max_speed = obj.max_speed;
    while count <= max_iterator
       % calc best fitness
       for i=1:pop
          fit_value = fitness(individuals_pos(i,:));
          if fit_value < individuals_best_fitness(i);
              individuals_best_fitness(i) = fit_value;
              individuals_best_pos(i,:) = individuals_pos(i,:);
          end
          if fit_value < pop_best_fitness
              pop_best_fitness = fit_value;
              pop_best_pos = individuals_pos(i,:);
          end          
       end
       % calc speed
       for i=1:pop
          speed(i,:) = obj.W * speed(i,:) + ...
                       obj.c1 * rand() * (individuals_best_pos(i,:) - individuals_pos(i,:)) + ...
                       obj.c2 * rand() * (pop_best_pos - individuals_pos(i,:));
          for j=1:obj.dimension
              if speed(i,j) > max_speed
                  speed(i,j) = max_speed;
              end
              if speed(i,j) < -max_speed
                  speed(i,j) = -max_speed;
              end
          end           
       end
       %update position
       individuals_pos = individuals_pos + speed;
       
       count = count + 1;
       disp(['count:',num2str(count),'; ','best_fitness: ',num2str(pop_best_fitness)]);
       
       obj.pop_best_fitness = pop_best_fitness;
       obj.pop_best_pos = pop_best_pos;
    end

end

