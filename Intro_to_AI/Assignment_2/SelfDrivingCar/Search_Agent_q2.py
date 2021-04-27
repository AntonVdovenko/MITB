import random
import math
from environment import Agent, Environment
from simulator import Simulator
import sys
from searchUtils import searchUtils

class SearchAgent(Agent):
    """ An agent that drives in the Smartcab world.
        This is the object you will be modifying. """ 

    def __init__(self, env,location=None):
        super(SearchAgent, self).__init__(env)     # Set the agent in the evironment 
        self.valid_actions = self.env.valid_actions  # The set of valid actions
        self.action_sequence=[]
        self.searchutil = searchUtils(env)

    def choose_action(self):
        """ The choose_action function is called when the agent is asked to choose
            which action to take next"""

        # Set the agent state and default action
        action=None
        if len(self.action_sequence) >=1:
            action = self.action_sequence[0] 
        if len(self.action_sequence) >=2:
            self.action_sequence=self.action_sequence[1:]
        else:
            self.action_sequence=[]
        return action

    def drive(self,goalstates,inputs):
        # Implementation of pseudo code
        def A_Star(start, goal):
            open_set = [start]
            close_set = []
            previous_state = {}
            g_score = {start['location']: 0}
            f_score = {start['location']: heuristic_cost_estimate(start['location'], goal['location'])}
            current = []

            while open_set is not None:

                if len(open_set) == 1:
                    current = open_set[0]
                else:
                    if len(f_score) >= 1:
                        min_f_score = min(f_score, key=f_score.get)
                        current = [d for d in open_set if d['location'] == min_f_score][0]

                    else:
                        return (False, [None])

                if current['location'] == goal['location']:
                    return (True, reconstruct_path(previous_state, current))

                open_set.remove(current)

                try:
                    del f_score[current['location']]
                except:
                    pass
                close_set.append(current)

                for action in ['forward-3x', 'forward-2x', 'forward', 'left', 'right', None]:
                    neighbor = self.env.applyAction(self, current, action)
                    if neighbor['location'] == current['location']:
                        continue
                    tentative_g_score = g_score[current['location']] + 1

                    if neighbor not in open_set:
                        open_set.append(neighbor)
                    elif tentative_g_score >= g_score[neighbor["location"]]:
                        continue

                    previous_state[neighbor['location']] = (current["location"], action)
                    g_score[neighbor['location']] = tentative_g_score
                    f_score[neighbor['location']] = g_score[neighbor['location']] + heuristic_cost_estimate(
                        neighbor['location'], goal['location'])

            if current == goal:
                return (True, reconstruct_path(previous_state, current))
            else:
                return (False, reconstruct_path(previous_state, current))

        def reconstruct_path(previous_state, current):
            total_path = []
            action_step = []

            while 'previous' in current:
                total_path.append(current)
                current = current['previous']

            total_path.append(current)
            total_path = [*reversed(total_path)]

            for i in range(len(total_path) - 1):
                action_step.append(self.env.getAction(total_path[i], total_path[i + 1]))

            return action_step

        def heuristic_cost_estimate(start, goal):
            return (abs(goal[0] - start[0]) + abs(goal[1] - start[1])) / 2

        if_reach, act_sequence = A_Star(self.state, goalstates[0])

        x_pos = self.state['location'][1]
        if if_reach == True:
            return act_sequence
        elif x_pos > 16:
            return [None]
        else:
            return act_sequence[:1]

    def update(self):
        """ The update function is called when a time step is completed in the 
            environment for a given trial. This function will build the agent
            state, choose an action, receive a reward, and learn if enabled. """
        startstate = self.state
        goalstates =self.env.getGoalStates()
        inputs = self.env.sense(self)
        self.action_sequence = self.drive(goalstates,inputs)
        action = self.choose_action()  # Choose an action
        self.state = self.env.act(self,action)        
        return
        

def run(filename):
    """ Driving function for running the simulation. 
        Press ESC to close the simulation, or [SPACE] to pause the simulation. """

    env = Environment(config_file=filename,fixmovement=False)
    
    agent = env.create_agent(SearchAgent)
    env.set_primary_agent(agent)
    
    ##############
    # Create the simulation
    # Flags:
    #   update_delay - continuous time (in seconds) between actions, default is 2.0 seconds
    #   display      - set to False to disable the GUI if PyGame is enabled
    sim = Simulator(env, update_delay=2)
    
    ##############
    # Run the simulator
    ##############
    sim.run()


if __name__ == '__main__':
    run(sys.argv[1])
