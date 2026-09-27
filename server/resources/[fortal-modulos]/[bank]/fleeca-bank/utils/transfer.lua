function transferCompleted(user_id,amount,nuser_id)
    remBalance({user_id = user_id,bank = amount})
    setBalance({user_id = nuser_id,bank = amount})
end