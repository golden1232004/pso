%test
pop = 20;
max_error = 0.001;
max_iterator = 100;
dimension = 2;

pso = PSO(pop, max_error, max_iterator, dimension);
pso.train;
pso.get('pop_best_fitness')
pso.get('pop_best_pos')