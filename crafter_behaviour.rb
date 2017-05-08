while true
	if tem algum cartão em `Ready for Delivery` && não tem nenhum cartão em [`Staging/Draft`, `Review`] relativo ao mesmo projeto
		pergunte no slack se está liberado para fazer deploy
		if resposta positiva 
			faça o deploy
			avise ao cliente que está em produção quando o deploy terminar
		end
	elsif tem algum cartão em `Staging/Draft`
		mova o cartão para `Review`
		avise no slack ao responsável pelo cartão
		teste a funcionalidade em staging
		if funcionou corretamente
			mova o cartão para `Ready for Delivery`
		else
			avise ao responsável pelo cartão dos problemas
		end
	else
		if tem algum cartão em `PR Ready`
			mova o cartão para `PR Review`
			avise no slack ao responsável pelo cartão
			analise o código no github
			if você estiver satisfeito
				aprove o Pull Request
			else 
				faça os comentários no código, pedindo mudanças ou tirando dúvidas
			end
			avise aos responsável pelo cartão
		else
			mova o primeiro cartão da coluna `Selected` para a coluna `Working on`
			while seu cartão não foi aprovado em staging
				crie uma branch no github a partir da branch develop com um bom nome 
				while você não criou um PR
					tire_duvidas
					while você não está satisfeito com o seu trabalho
						programe
					end
					suba seu código pro repositório remoto
					crie um Pull Request (PR)
				end
				faça um comentário no cartão com link para o PR
				mova o cartão para a coluna `PR Review`
				while ninguém revisou seu código
					notifique
				end
				while seu PR não foi aprovado
					tire_duvidas
					while você não está satisfeito com o seu trabalho
						programe
					end
					suba seu código pro repositório remoto
					avise no slack ao seu revisor
				end
				faça merge do seu código com a develop if build no cli passou
				mova seu cartão para a coluna `Staging/Draft`
				avise o cliente que está em staging quando o build terminar
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
		tire dúvidas no slack no canal relacionado ao projeto ou no developers
	end
end
	
def programe
	programe pra caraleo pra resolver o problema no cartão
	rode o build no ambiente local ('rubocop -Ra && rspec')
	while not (todos os testes passaram and cobertura 100% and rubocop não identificou ofensas)
		faça alterações no código
	end
end
