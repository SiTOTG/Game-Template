class_name Helper extends Node


# Deep recursive merging.
## Does not currently support string!!
static func merge_recurssively(dict1: Dictionary, dict2: Dictionary):
	# Iterate through keys in dict2 to merge individually
	for key in dict2:
		if not key in dict1:
			# If value is not in dict1 add it as a new value
			var value = dict2[key]
			if value is Dictionary:
				dict1[key] = value.duplicate(true)
			else:
				dict1[key] = value
		else:
			# If value is not in dict one, need to merge
			var value = dict2[key]
			# Dict2 is a dictionary but dict1 isn't
			if value is Dictionary:
				if dict1[key] is not Dictionary:
					dict1[key] = value.duplicate(true)
				else:
					# Both dictionary, need to merge further
					merge_recurssively(dict1[key], value)
			else:
				# Not a dictionary, override
				dict1[key] = value
			
