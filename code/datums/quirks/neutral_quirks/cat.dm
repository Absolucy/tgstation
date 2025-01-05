/datum/quirk/cat
	name = "Cat"
	desc = "this just gives any species cat ears and a tail"
	icon = FA_ICON_CAT
	value = 0
	medical_record_text = "Cat."

/datum/quirk/cat/add(client/client_source)
	purrbation_apply(quirk_holder, silent = TRUE)

/datum/quirk/cat/remove(client/client_source)
	purrbation_remove(quirk_holder, silen = TRUE)
