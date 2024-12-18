/**
 * Component which allows an equipped item to occasionally absorb a projectile.
 */
/datum/component/bullet_intercepting
	/// Chance to intercept a projectile
	var/block_chance
	/// Type of bullet to intercept
	var/block_type
	/// Slots in which effect can be active
	var/active_slots
	/// Person currently wearing us
	var/mob/wearer
	/// Callback called when we catch a projectile
	var/datum/callback/on_intercepted
	/// Number of things we can block before we delete ourself (stop being able to block)
	var/block_charges = INFINITY

/datum/component/bullet_intercepting/Initialize(block_chance = 2, block_type = BULLET, active_slots, datum/callback/on_intercepted, block_charges = INFINITY)
	. = ..()
	if (!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	src.block_chance = block_chance
	src.block_type = block_type
	src.active_slots = active_slots
	src.on_intercepted = on_intercepted
	src.block_charges = block_charges

	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_parent_equipped))
	RegisterSignal(parent, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(on_unequipped))

/datum/component/bullet_intercepting/Destroy(force)
	wearer = null
	on_intercepted = null
	return ..()

/// Called when item changes slots, check if we're in a valid location to take bullets
/datum/component/bullet_intercepting/proc/on_parent_equipped(obj/item/clothing/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if (wearer)
		if (!(active_slots & slot))
			on_unequipped()
		return

	if (!(active_slots & slot))
		return
	RegisterSignal(equipper, COMSIG_PROJECTILE_PREHIT, PROC_REF(on_wearer_shot))
	RegisterSignal(equipper, COMSIG_QDELETING, PROC_REF(on_wearer_deleted))
	wearer = equipper

/// Called when item is unequipped, stop tracking bullets
/datum/component/bullet_intercepting/proc/on_unequipped()
	SIGNAL_HANDLER
	if (!wearer)
		return
	UnregisterSignal(wearer, list(COMSIG_PROJECTILE_PREHIT, COMSIG_QDELETING))
	wearer = null

/// Called when wearer is shot, check if we're going to block the hit
/datum/component/bullet_intercepting/proc/on_wearer_shot(mob/living/victim, obj/projectile/bullet)
	SIGNAL_HANDLER
	if (victim != wearer || victim.stat == DEAD || bullet.armor_flag != block_type)
		return NONE
	if (!prob(block_chance))
		return NONE
	on_intercepted?.Invoke(victim, bullet)
	block_charges--
	if (block_charges <= 0)
		qdel(src)
	return PROJECTILE_INTERRUPT_HIT

/// Called when wearer is deleted, stop tracking them
/datum/component/bullet_intercepting/proc/on_wearer_deleted()
	SIGNAL_HANDLER
	wearer = null
