extends Node


func _ready() -> void:
	var d1 = {
		# Should be replaced
		"simple_in_both": "simple_in_both_original",
		# Should continue existing unchanged
		"simple_only_original": "simple_only_original",
		# Should be replaced
		"dict_in_original_simple_in_new": {
			"doesn't matter inside": 1,
			2: 3
		},
		# Should be replaced
		"simple_in_original_dict_in_new": "simple_in_original_dict_in_new_original",
		# Merge case
		"dict_in_both": {
			"s1": "s1o",
			"s2": "s2o",
			"d1": {
				"d1": {
					"s1": "s1o"
				}
			}
		}
	}
	
	var d2 = {
		"simple_in_both": "simple_in_both_new",
		"dict_in_original_simple_in_new": "dict_in_original_simple_in_new_new_value",
		"simple_in_original_dict_in_new": {
			"should_be_here": "should_be_unchanged"
		},
		"dict_in_both": {
			"s1": "s1n",
			"s3": "s3n",
			"d1": {
				"d1": {
					"s1": "s1n"
				}
			}
		}
	}
	
	Helper.merge_recurssively(d1, d2)
	# Verifications
	assert(d1["simple_in_both"] == "simple_in_both_new")
	assert(d1["simple_only_original"] == "simple_only_original")
	assert(d1["dict_in_original_simple_in_new"] == "dict_in_original_simple_in_new_new_value")
	assert(d1["simple_in_original_dict_in_new"] is Dictionary)
	assert(d1["simple_in_original_dict_in_new"]["should_be_here"] == "should_be_unchanged")
	assert(d1["dict_in_both"].recursive_equal(
		{
			# Exists in both, replace
			"s1": "s1n",
			# Exists only in old, keep
			"s2": "s2o",
			# Deep recursion test
			"d1": {
				# Go deeper to be sure
				"d1": {
					# Exists in both, replace
					"s1": "s1n" 
				} 
			},
			# Exists only in new, add
			"s3": "s3n" 
		},
		10
	))
	print(d1)
