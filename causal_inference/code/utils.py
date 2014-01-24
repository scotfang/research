#Utilities.
#Scot Fang 1/14/2014

def energyToProbability(energy):
	return math.exp(-energy)

def probabilityToEnergy(probability, defaultZeroProbabilityEnergy=None):
	if probability == 0:
        assert(defaultZeroProbabilityEnergy)
		return defaultZeroProbabilityEnergy
	else:
		return -math.log(probability)
