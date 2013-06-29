classdef PSO < handle %this makes PSO subclass of handle class 
%If you want to create a class that defines events, you must derive that class from the handle class.
    
    
    properties( Constant)
        %constant
        version='1.0';
        W = 1.1;
        c1 = 2;
        c2 = 2;       
    end
    properties    
        %input arguments
        pop;           % population
        max_error;
        max_iterator;
        dimension;
    end
    properties (GetAccess = private)
        %init arguments
        pop_best_fitness;             %1*1
        pop_best_pos;                 %1*dimension; best position of population
        individuals_best_fitness;     %pop * 1; all individual best fitness
        individuals_best_pos;         %pop * dimension
        individuals_pos;
        individuals_speed;
        max_speed = 0.5;
    end
    
    methods
        function obj = PSO( varargin)
           if nargin<4
               error('Input arguments is not enough');
           end
           obj.pop = varargin{1};
           obj.max_error = varargin{2};
           obj.max_iterator = varargin{3};
           obj.dimension = varargin{4};
            
           %init arguments
           obj.pop_best_fitness = 1/eps;
           obj.pop_best_pos = rand(1, obj.dimension);
           obj.individuals_best_fitness = Inf * rand(obj.pop, 1);
           obj.individuals_best_pos = rand(obj.pop, obj.dimension);
           obj.individuals_pos = rand(obj.pop, obj.dimension);
           obj.individuals_speed = rand(obj.pop, obj.dimension);
        end
        % properties 
        function population = get.pop(obj)    %call mathod is populaton = obj.opo;
            population = obj.pop;
        end
        function set.pop(obj, population)     %set mathod is obj.pop = value;
            obj.pop = population;
        end
        
        function error = get.max_error(obj)
            error = obj.max_error; 
        end
        function set.max_error(obj, error)
            obj.max_error = error; 
        end
        
        function maxIterator = get.max_iterator(obj)
            maxIterator = obj.max_iterator;
        end
        function set.max_iterator(obj, maxIterator)
            obj.max_iterator = maxIterator;
        end
        
        function dim = get.dimension(obj)
            dim = obj.dimension;
        end
        function set.dimension(obj, dim)
            obj.dimension = dim;
        end
        
        function [prop_value] = get(obj,prop_name)
           switch prop_name
               case 'pop_best_fitness'
                   prop_value = obj.pop_best_fitness;
               case 'pop_best_pos'
                   prop_value = obj.pop_best_pos;
               otherwise
                   error('Input argument error!\n');
           end
        end
        % method defined in other M-files
        train(obj, varargin);
    end
    
end

