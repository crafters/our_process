while true
	if tem algum cartão em `Staging/Draft`
		move o cartão para `Review`
		avisa no slack ao responsável pelo cartão
		testa a funcionalidade em staging
		if funcionou direito
			move o cartão para `Ready for Delivery`
		else
			avisa ao responsável pelo cartão dos problemas
			bloqueia o cartão
		end
	else
		if tem algum cartão em `PR Ready`
			move o cartão para `PR Review`
			avisa no slack ao responsável pelo cartão
			analisa o código no github
			if você estiver satisfeito
				aprova o Pull Request
			else 
				faz os comentários no código, pedindo mudanças ou tirando dúvidas
			end
			avisa aos responsável pelo cartão
		else
			move o primeiro cartão da coluna `Selected` para a coluna `Working on`
			while seu cartão não foi aprovado em staging
				cria uma branch no github a partir da branch develop com um bom nome 
				while você não criou um PR
					tire_duvidas
					while você não está satisfeito com o seu trabalho
						programe
					end
					sobe seu código pro repositório remoto
					cria um Pull Request (PR)
				end
				faz um comentário no cartão com link para o PR
				move o cartão para a coluna `PR Review`
				while ninguém revisou seu código
					notifique
				end
				while seu PR não foi aprovado
					tire_duvidas
					while você não está satisfeito com o seu trabalho
						programe
					end
					sobe seu código pro repositório remoto
					avisa no slack ao seu revisor
				end
				faz merge do seu código com a develop if build no cli passou
				move seu cartão para a coluna `Staging/Draft`
				while ninguém revisou em staging
					notifique
				end
			end
			abra uma cerveja e faça a dancinha da vitória porque uma criação sua vai ajudar a vida de alguém
		end
	end
end
		
def notifique
	if é a primeira interação
		avise no canal do projeto com `@here` e o link pro seu PR
	else
		avise no canal do projeto com `@nome_do_revisor` e o link pro seu PR
	end
	aguarde 2 minutos e 15 segundos
end
	
def tire_duvidas
	while tem dúvidas
		tira dúvidas no slack no canal relacionado ao projeto ou no developers
	end
end
	
def programe
	programa pra caraleo pra resolver o problema no cartão
	roda o build no ambiente local ('rubocop -Ra && rspec')
	while not (todos os testes passaram and cobertura 100% and rubocop não identificou ofensas)
		faz alterações no código
	end
end
