/datum/preference/choiced/ethereal_color
	savefile_key = "feature_ethcolor"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Ethereal color"
	should_generate_icons = TRUE

/datum/preference/choiced/ethereal_color/init_possible_values()
	return assoc_to_keys(GLOB.color_list_ethereal)

/datum/preference/choiced/ethereal_color/icon_for(value)
	var/static/icon/ethereal_base
	if (isnull(ethereal_base))
		ethereal_base = icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_head")
		ethereal_base.Blend(icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_chest"), ICON_OVERLAY)
		ethereal_base.Blend(icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_l_arm"), ICON_OVERLAY)
		ethereal_base.Blend(icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_r_arm"), ICON_OVERLAY)

		var/icon/eyes = icon('icons/mob/human/human_face.dmi', "eyes")
		eyes.Blend(COLOR_BLACK, ICON_MULTIPLY)
		ethereal_base.Blend(eyes, ICON_OVERLAY)

		ethereal_base.Scale(64, 64)
		ethereal_base.Crop(15, 64, 15 + 31, 64 - 31)

	var/icon/icon = new(ethereal_base)
	icon.Blend(GLOB.color_list_ethereal[value], ICON_MULTIPLY)
	return icon

/datum/preference/choiced/ethereal_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ethcolor"] = GLOB.color_list_ethereal[value]

/datum/preference/choiced/ethereal_horns
	savefile_key = "feature_ethereal_horns"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Ethereal Horns"
	should_generate_icons = TRUE

/datum/preference/choiced/ethereal_horns/init_possible_values()
	return assoc_to_keys_features(SSaccessories.ethereal_horns_list)

/datum/preference/choiced/ethereal_horns/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ethereal_horns"] = value

/datum/preference/choiced/ethereal_tail
	savefile_key = "feature_ethereal_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Ethereal Tail"
	should_generate_icons = TRUE

/datum/preference/choiced/ethereal_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_ethereal)

/datum/preference/choiced/ethereal_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ethereal_tail"] = value
